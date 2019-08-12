import 'package:flutter_app/conf/ColorConf.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Toast 工具类
class ToastUtils {
  static showTs(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: ColorConf.colorF0F0F0,
        textColor: ColorConf.color48586D,
        fontSize: 16.0);
  }
}
