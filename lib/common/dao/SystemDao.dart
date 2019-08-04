import 'package:flutter_app/common/bean/impl/system_tree_impl_entity.dart';

import 'BaseDao.dart';

class SystemDao extends BaseDao {
  /// 获取体系列表
  Future<SystemTreeImplEntity> getSystemTree() async {
    var result = await getHttpUtils().netFetch('tree/json');
    if (result != null) {
      return SystemTreeImplEntity.fromJson(result);
    } else {
      return new SystemTreeImplEntity();
    }
  }
}
