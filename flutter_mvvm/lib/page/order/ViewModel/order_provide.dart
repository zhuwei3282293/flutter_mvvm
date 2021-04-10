import 'package:flutter_mvvm/base/base_provide.dart';
import 'package:flutter_mvvm/page/order/Model/order.dart';
import 'package:flutter_mvvm/page/order/Model/order_repository.dart';
import 'package:rxdart/rxdart.dart';

class OrderProvide extends BaseProvide {
  // 页数
  int _page = 0;
  int get page => _page;
  set page(int page) {
    _page = page;
  }

  final subjectMore = new BehaviorSubject<bool>();
  bool _hasMore = false;
  bool get hasMore => _hasMore;
  set hasMore(bool hasMore) {
    _hasMore = hasMore;
    subjectMore.add(hasMore);
  }

  List<Order> _dataArr = [];
  List<Order> get dataArr => _dataArr;
  set dataArr(List<Order> arr) {
    _dataArr = arr;
    this.notify();
  }

  int _count = 0;
  int get count => _count;
  set count(int count) {
    _count = count;
    notify();
  }

  expand(int index) {
    // this.count = index;
    // this.dataArr[index].isExpaned = !this.dataArr[index].isExpaned;
    notify();
  }

  final OrderRepo _repo = OrderRepo();

  notify() {
    notifyListeners();
  }

  Observable getOrderList(bool isRefrsh) {
    isRefrsh ? page = 0 : page++;

    var query = {
      'token': 'aaaaaaaa',
      'orderType': 1,
      'pageNum': this.page,
      'pageSize': 10
    };
    return _repo
        .getOrderList(query)
        .doOnData((result) {
          if (isRefrsh) {
            this.dataArr.clear();
          }
          var arr = result.data as List;
          this.dataArr.addAll(arr.map((map) => Order.fromJson(map)));
          this.hasMore = result.total > this.dataArr.length;
          this.notify();
        })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }
}
