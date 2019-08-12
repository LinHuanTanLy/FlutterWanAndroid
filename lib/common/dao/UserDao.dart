import 'dart:convert';

import 'package:flutter_app/common/bean/impl/user_info_impl_entity.dart';
import 'package:flutter_app/utils/cache/SpUtils.dart';
import 'package:flutter_app/utils/toast/ToastUtils.dart';

import 'BaseDao.dart';

/// 用户信息
class UserDao extends BaseDao {
  /// 登录方法
  login(String userName, String passWord, Function success) {
    if (userName.isEmpty || passWord.isEmpty) {
      ToastUtils.showTs('账号密码不能为空');
      return;
    }
    var params = {'username': userName, 'password': passWord};
    getHttpUtils().post('user/login', params, (result) {
      UserInfoImplEntity _userInfo = UserInfoImplEntity.fromJson(result);
      SpUtils.saveString("sp_user_info", json.encode(_userInfo));
      success(_userInfo);
    });
  }
}
