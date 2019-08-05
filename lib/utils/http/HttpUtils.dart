import 'dart:collection';

import 'package:dio/dio.dart';

import 'ResultData.dart';

class HttpUtils {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  Dio _dio; // 使用默认配置
  static HttpUtils _instance;

  static HttpUtils getInstance() {
    if (_instance == null) {
      _instance = new HttpUtils();
    }
    return _instance;
  }

  HttpUtils() {
    BaseOptions options = new BaseOptions(
      baseUrl: "https://www.wanandroid.com/",
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    _dio = new Dio(options);
  }

  netFetch(url, {params, Map<String, dynamic> header, Options options}) async {
    print('the url is $url');
    Map<String, dynamic> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }
    if (options != null) {
      options.headers = headers;
    } else {
      options = new Options(method: 'get');
      options.headers = headers;
    }

    resultError(DioError e) {
      Response errResponse;
      if (e.response != null) {
        errResponse = e.response;
      } else {
        errResponse = new Response(statusCode: 500);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errResponse.statusCode = 400;
      }
      return new ResultData(null, false, errResponse.statusCode);
    }

    Response response;
    try {
      response = await _dio.request(url, data: params, options: options);
    } on DioError catch (e) {
      return resultError(e);
    }
    if (response.data is DioError) {
      return resultError(response.data);
    }
    return response.data;
  }
}
