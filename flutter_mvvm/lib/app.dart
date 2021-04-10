import 'package:flutter/material.dart';
import 'package:flutter_mvvm/base/base_provide.dart';
import 'package:flutter_mvvm/main_provide.dart';
import 'package:flutter_mvvm/page/page1/page1.dart';
import 'package:flutter_mvvm/page/page2/page2.dart';

import 'package:provider/provider.dart';

class App extends PageProvideNode {
  App();
  @override
  Widget buildContent(BuildContext context) {
    // ignore: todo
    // TODO: implement buildContent
    return _AppContentPage();
  }
}

class _AppContentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<_AppContentPage>
    with TickerProviderStateMixin<_AppContentPage> {
  MainProvide _mainProvide;
  Page1 _page1;
  Page2 _page2;
  TabController controller;

  Animation<double> _animation;
  AnimationController _animationController;

  final _tranTween = new Tween<double>(begin: 1, end: 0);

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _mainProvide = MainProvide.instance;

    controller = new TabController(length: 3, vsync: this);

    _animationController = new AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation =
        new CurvedAnimation(parent: _animationController, curve: Curves.linear);
  }

  @override
  void dispose() {
    super.dispose();
    print("app释放");
  }

  ontap(int index) {
    _mainProvide.currentIndex = index;
    controller.animateTo(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    var changeNotifierProvider = ChangeNotifierProvider(
      create: (context) => _mainProvide,
      child: new Scaffold(
          body: new Stack(
            clipBehavior: Clip.hardEdge,
            alignment: AlignmentDirectional.bottomEnd,
            // children: <Widget>[_initTabBarView()],
          ),
          bottomNavigationBar: _initBottomNavigationBar()),
    );
    return changeNotifierProvider;
  }

  Widget _initTabBarView() {
    return Consumer(builder:
        (BuildContext context, MainProvide mainProvider, Widget child) {
      return IndexedStack(
        index: _mainProvide.currentIndex,
        children: <Widget>[_page1, _page2],
      );
    });
  }

  Widget _initBottomNavigationBar() {
    return Theme(
        data: new ThemeData(
            canvasColor: Colors.white, // BottomNavigationBar背景色
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: TextStyle(color: Colors.grey))),
        child: Consumer(builder:
            (BuildContext context, MainProvide mainProvider, Widget child) {
          return BottomNavigationBar(
              fixedColor: Colors.red,
              currentIndex: mainProvider.currentIndex,
              onTap: ontap,
              type: BottomNavigationBarType.fixed,
              items: [
                new BottomNavigationBarItem(
                    icon: new Icon(Icons.music_video), label: '卡片1'),
                new BottomNavigationBarItem(
                    icon: new Icon(Icons.music_note), label: '卡片2'),
              ]);
        }));
  }
}
