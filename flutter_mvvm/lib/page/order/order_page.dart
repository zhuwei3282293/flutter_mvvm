import 'package:flutter/material.dart';
import 'package:flutter_mvvm/widgets/dialog/dialog.dart';
import 'package:flutter_mvvm/widgets/refresh/smart_refresher.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'Model/order.dart';
import 'ViewModel/order_provide.dart';
import 'package:flutter_mvvm/config/app_config.dart';

class OrderPage extends StatefulWidget {
  OrderPage();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrderContentPage();
  }
}

class _OrderContentPage extends State<OrderPage> {
  final _subscriptions = CompositeSubscription();

  RefreshController _refreshController;
  ScrollController _scrollControll;

  final _loading = LoadingDialog();

  final _cellHeight = 80.0;
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  OrderProvide _provide = OrderProvide();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = new RefreshController();
    _scrollControll = new ScrollController();
    _loadData();
    _provide.subjectMore.listen((hasMore) {
      print("_provide.subjectMore.listen${hasMore}");
      if (hasMore) {
        _refreshController.sendBack(false, RefreshStatus.init);
      } else {
        if (_provide.dataArr.length > 0) {
          _refreshController.sendBack(false, RefreshStatus.noMore);
        }
      }
    });
    print("首页--initState");
  }

  @override
  void dispose() {
    super.dispose();
    print("首页释放");
    _subscriptions.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('home-build(BuildContext context)');

    return ChangeNotifierProvider.value(
      value: _provide,
      child: Scaffold(
        appBar: new AppBar(
          title: new Text('订单列表'),
          leading: new IconButton(
              icon: new Icon(Icons.my_location), onPressed: _pushSaved),
          centerTitle: true,
          actions: <Widget>[],
        ),
        body: _initView(),
      ),
    );
  }

  Widget _initView() {
    return Consumer<OrderProvide>(
      builder: (build, provide, _) {
        print('Consumer-initView');
        return _provide.dataArr.length > 0
            ? _buildListView()
            : AppConfig.initLoading(false);
      },
    );
  }

  Widget _buildListView() {
    return new Column(children: <Widget>[
      Consumer<OrderProvide>(
        builder: (build, provide, _) {
          print('Consumer1');
          return new Text(
              '${_provide.count}---该页面验证Consumer，点击cell上的图标展开一个cell，观察控制台的打印情况，结论：只要发送通知后使用Consumer的部分全部都会重绘，再其他页面我会使用Selector来验证局部的刷新');
        },
      ),
      new Expanded(
          child: new SmartRefresher(
        child: new ListView.builder(
            itemCount: _provide.dataArr.length,
            controller: _scrollControll,
            itemBuilder: (context, i) {
              return getRow(_provide.dataArr[i], i);
            }),
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        onHeaderRefresh: _onHeaderRefresh,
        onFooterRefresh: _onFooterRefresh,
        onOffsetChange: _onOffsetCallback,
      ))
    ]);
  }

  Widget getRow(Order order, int index) {
    return Consumer<OrderProvide>(
      builder: (build, provide, _) {
        print('Consumer--getRow${index}');

        return new Column(
          children: <Widget>[
            new Container(
              height: _cellHeight,
              padding: EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: new InkWell(
                onTap: () {},
                child: new Row(
                  children: <Widget>[
                    new Container(
                      width: 8,
                    ),
                    new Expanded(
                        child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          height: 4,
                        ),
                        new Text(order.orderNumber,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left),
                        new Container(
                          height: 8,
                        ),
                      ],
                    )),
                    new InkWell(
                      onTap: () {},
                      child: new Container(
                        width: 40,
                        height: 70,
                        child: new Icon(
                          Icons.more_horiz,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              height: 0,
              color: Colors.blue,
            )
          ],
        );
      },
    );
  }

  _pushSaved() {}
  _loadData([bool isRefresh = true]) {
    var s = _provide
        .getOrderList(isRefresh)
        .doOnListen(() {})
        .doOnCancel(() {})
        .listen((data) {
      if (isRefresh) {
        _refreshController.sendBack(true, RefreshStatus.idle);
      }
    }, onError: (e) {});
    _subscriptions.add(s);
  }

  _onHeaderRefresh() {
    _loadData();
  }

  _onFooterRefresh() {
    if (_provide.hasMore) {
      _loadData(false);
    }
  }

  _onOffsetCallback(bool up, double offset) {}
}
