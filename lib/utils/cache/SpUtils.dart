import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// sp工具类
class SpUtils {
  /// 保存文本
  static saveString(String key, String msg) async {
    if (msg != null && msg.isNotEmpty) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(key, msg).then((value) {
        debugPrint('save $msg resule is $value');
      });
    }
  }

  /// 获取文本
  Future<String> getSpString(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String result = sharedPreferences.getString(key);
    debugPrint('getString $key resule is $result');
    return result;
  }
}
