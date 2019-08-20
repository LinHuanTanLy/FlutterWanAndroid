import 'package:flutter_app/common/bean/impl/user_info_impl_entity.dart';
import 'package:flutter_app/redux/AppState.dart';

import 'AppAction.dart';

/// 用户更新的action
class UserUpdateAction extends AppAction {
  final UserInfoImplEntity _userInfoImplEntity;

  UserInfoImplEntity get() => _userInfoImplEntity;

  UserUpdateAction(UserInfoAction type, this._userInfoImplEntity) : super(type);
}
