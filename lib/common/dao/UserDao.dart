import 'dart:convert';

import 'package:flutter_app/common/bean/impl/user_info_impl_entity.dart';
import 'package:flutter_app/utils/cache/CacheKey.dart';
import 'package:flutter_app/utils/cache/SpUtils.dart';
import 'package:flutter_app/utils/toast/ToastUtils.dart';

import 'BaseDao.dart';

/// 用户信息
class UserDao extends BaseDao {
  /// 登录方法
  login(String userName, String passWord, Function success, Function error) {
    if (userName.isEmpty || passWord.isEmpty) {
      ToastUtils.showTs('账号密码不能为空');
      error(-1);
      return;
    }
    var params = {'username': userName, 'password': passWord};
    getHttpUtils().post('user/login', params, (result) {
      UserInfoImplEntity _userInfo = UserInfoImplEntity.fromJson(result);
      SpUtils.saveString(CacheKey.cacheUserInfo, json.encode(_userInfo));
      success(_userInfo);
    }, error: error);
  }

  /// 注册
  register(String userName, String psd, String psdConfirm, Function success,
      Function error) {
    if (userName.isEmpty || psd.isEmpty || psdConfirm.isEmpty) {
      ToastUtils.showTs("账号密码不能为空");
      error();
      return;
    }
    if (psd != psdConfirm) {
      ToastUtils.showTs('两次密码不一致');
      error();
      return;
    }
    var params = {
      'username': userName,
      'password': psd,
      'repassword': psdConfirm
    };
    getHttpUtils().post("user/register", params, (result) {
      UserInfoImplEntity _userInfo = UserInfoImplEntity.fromJson(result);
      SpUtils.saveString(CacheKey.cacheUserInfo, json.encode(_userInfo));
      success(_userInfo);
    }, error: error);
  }
}
