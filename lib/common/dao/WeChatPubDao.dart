import 'package:flutter_app/common/bean/impl/we_chat_pub_child_list_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/we_chat_pub_list_impl_entity.dart';

import 'BaseDao.dart';

/// 微信公众号的dao
class WeChatPubDao extends BaseDao {
  /// 获取公众号列表
  getWeChatList(Function success) {
    getHttpUtils().get('wxarticle/chapters/json', (value) {
      success(WeChatPubListImplEntity.fromJson(value));
    });
  }

  /// 获取公众号里面的文章列表
  getWeChatChildList(int pageIndex, int pubId, Function success) {
    getHttpUtils().get('wxarticle/list/$pubId/$pageIndex/json', (result) {
      success(WeChatPubChildListImplEntity.fromJson(result));
    });
  }

  /// 获取本地头像
  List<String> getAuthorPicList() {
    List<String> _list = [];
    for (int i = 0; i < 18; i++) {
      _list.add('images/author_pic$i.jpg');
    }
    return _list;
  }
}
