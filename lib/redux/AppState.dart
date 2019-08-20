import 'package:flutter_web/material.dart';
import 'package:flutter_app/common/bean/impl/user_info_impl_entity.dart';
import 'package:meta/meta.dart';

import 'action/UserUpdateAction.dart';

/// app的总体state
@immutable
class AppState {
  final UserInfoImplEntity _userInfoImpl;

  get userInfo => _userInfoImpl;

  AppState(this._userInfoImpl);

  AppState.initState() : _userInfoImpl = new UserInfoImplEntity();
}

enum UserInfoAction {
  update,
}

AppState reducer(AppState state, action) {
  debugPrint('thie is the action = $action');
  if (action is UserUpdateAction) {
    return AppState(action.get());
  } else {
    return state;
  }
}
