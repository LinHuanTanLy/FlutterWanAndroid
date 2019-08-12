import 'package:flutter_app/common/bean/impl/user_info_impl_entity.dart';

import 'BaseDao.dart';

class UserDao extends BaseDao {
  Future<UserInfoImplEntity> login(String userName, String passWord) async {
    if (userName.isEmpty || passWord.isEmpty){

    }
      var params = {'username': '15622715239', 'password': '123456'};
    var result = await getHttpUtils().post('user/login', params);
    if (result != null) {
      return UserInfoImplEntity.fromJson(result);
    } else {
      return UserInfoImplEntity();
    }
  }
}
