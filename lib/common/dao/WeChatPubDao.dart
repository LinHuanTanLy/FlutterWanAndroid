import 'package:flutter_app/common/bean/impl/we_chat_pub_child_list_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/we_chat_pub_list_impl_entity.dart';

import 'BaseDao.dart';

/// 微信公众号的dao
class WeChatPubDao extends BaseDao {
  /// 获取公众号列表
  Future<WeChatPubListImplEntity> getWeChatList() async {
    var result = await getHttpUtils().netFetch('wxarticle/chapters/json');
    if (result != null) {
      return WeChatPubListImplEntity.fromJson(result);
    } else {
      return new WeChatPubListImplEntity();
    }
  }

  /// 获取公众号里面的文章列表
  Future<WeChatPubChildListImplEntity> getWeChatChildList(
      int pageIndex, int pubId) async {
    var result =
        await getHttpUtils().netFetch('wxarticle/list/$pubId/$pageIndex/json');
    if (result != null) {
      return WeChatPubChildListImplEntity.fromJson(result);
    } else {
      return new WeChatPubChildListImplEntity();
    }
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
