import 'package:flutter_app/utils/http/HttpUtils.dart';

abstract class BaseDao {
  HttpUtils httpUtils;

  HttpUtils getHttpUtils() {
    if (httpUtils == null) {
      httpUtils = new HttpUtils();
    }
    return httpUtils;
  }
}
