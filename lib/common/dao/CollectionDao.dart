import 'package:flutter_app/common/dao/BaseDao.dart';

/// 收藏列表
class CollectionDao extends BaseDao {
  /// 收藏站内文章
  collInner(String id,success,error) {
    getHttpUtils().post('lg/collect/$id/json', null, success,error: error);
  }
}
