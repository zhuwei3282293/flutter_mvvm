import 'package:flutter/widgets.dart';

abstract class BaseViewModel with ChangeNotifier {
  BaseViewModel(this.context);

  BuildContext context;
  //是否正在加载
  bool _isLoding = false;
  bool get isLoding => _isLoding;
  set isLoding(bool isLoding) {
    if (_isLoding != isLoding) {
      _isLoding = isLoding;
      this.notifyListeners();
    }
  }

  @protected
  Future refreshData({bool isShowLoding = true});
}
