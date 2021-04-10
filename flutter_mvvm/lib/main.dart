import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/app.dart';
import 'package:flutter_mvvm/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new App(),
      debugShowCheckedModeBanner: false, // 去除debug旗标
      theme: new ThemeData(
          primaryColor: new Color.fromRGBO(255, 255, 255, 1),
          highlightColor: Colors.red, //AppConfig.backgroundColor,
          splashColor: Colors.black, //AppConfig.backgroundColor,
          hintColor: Colors.grey,
          scaffoldBackgroundColor:
              new Color.fromRGBO(255, 255, 255, 1), //设置页面背景颜色
//          bottomAppBarColor: new Color.fromRGBO(19, 35, 63, 1), //设置底部导航的背景色
//          backgroundColor: new Color.fromRGBO(19, 35, 63, 1),
//          indicatorColor: new Color.fromRGBO(19, 35, 63, 1),    //设置tab指示器颜色

          primaryIconTheme:
              new IconThemeData(color: Colors.black), //主要icon样式，如头部返回icon按钮
          iconTheme:
              new IconThemeData(size: 18.0, color: Colors.white), //设置icon样式

          textTheme: new TextTheme(
              headline6: new TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
              subtitle2: new TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.normal)),
          primaryTextTheme: new TextTheme(
              //设置文本样式
              headline6: new TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold)),
          tabBarTheme: new TabBarTheme(
              labelColor: Colors.black, unselectedLabelColor: Colors.grey)),
    );
  }
}

class RandomWordState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("title",
            style: TextStyle(fontSize: 30.0, color: Colors.yellow)),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        final tiles = _saved.map((pair) {
          return new ListTile(
            title: new Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        });
        final divided =
            ListTile.divideTiles(tiles: tiles, context: context).toList();
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Saved Suggestions'),
          ),
          body: new ListView(children: divided),
        );
      }),
    );
  }

  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();

  Widget _buildSuggestions() {
    return new ListView.builder(itemBuilder: (context, i) {
      if (i.isOdd) return new Divider();
      final index = i ~/ 2;
      if (index >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_suggestions[index]);
    });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      //https://www.baidu.com/img/bdlogo.png
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      // trailing: new Image.network(
      //   "https://www.baidu.com/img/bdlogo.png",
      // ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordState();
}
