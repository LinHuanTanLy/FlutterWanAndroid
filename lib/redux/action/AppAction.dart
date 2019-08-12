import 'package:flutter_app/redux/AppState.dart';

/// Action的基类
class AppAction {
  final UserInfoAction type;

  AppAction(this.type);
}
