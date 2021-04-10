import 'package:flutter_mvvm/base/base_data.dart';
import 'package:flutter_mvvm/network/netUtils.dart';
import 'package:rxdart/rxdart.dart';

class OrderService {
  /// 获取列表 var body = {'token': '', 'orderType': '', 'pageNum': '', 'pageSize': ''};
  Observable<BaseResponse> getOrderList(
      dynamic request, Map<String, dynamic> query) {
    var url = 'canyin-service/order/bhorderlist';
    var response = post(url, body: request, queryParameters: query);
    return response;
  }
}

class OrderRepo {
  final OrderService _remote = OrderService();

  Observable<BaseResponse> getOrderList(Map<String, dynamic> query) {
    return _remote.getOrderList(null, query);
  }
}
