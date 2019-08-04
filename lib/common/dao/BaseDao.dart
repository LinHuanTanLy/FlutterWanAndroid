import 'package:flutter_app/utils/http/HttpUtils.dart';

abstract class BaseDao {
  HttpUtils httpUtils;

  getHttpUtils() {
    if (httpUtils == null) {
      httpUtils = new HttpUtils();
    }
    return httpUtils;
  }
}
