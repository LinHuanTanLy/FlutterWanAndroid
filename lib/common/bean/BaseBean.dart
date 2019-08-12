import 'BaseBeanInterface.dart';

 class BaseBean implements BaseBeanInterface {
  int errorCode;
  String errorMsg;

  @override
  int getCode() {
    return errorCode;
  }

  @override
  String getMessage() {
    return errorMsg;
  }


}
