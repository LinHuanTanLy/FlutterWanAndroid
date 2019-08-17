import 'package:flutter_app/common/bean/impl/my_collection_article_impl_entity.dart';
import 'package:flutter_app/common/dao/BaseDao.dart';
import 'package:flutter_app/utils/toast/ToastUtils.dart';

/// 收藏列表
class CollectionDao extends BaseDao {
  /// 收藏站内文章
  collectInnerArticle(int id, success, error) {
    getHttpUtils().post('lg/collect/$id/json', null, success, error: error);
  }

  /// 收藏站外文章
  collOutArticle(String title, String author, String link, success, error) {
    if (title != null &&
        title.isNotEmpty &&
        author != null &&
        author.isNotEmpty &&
        link != null &&
        link.isNotEmpty) {
      var params = {'title': title, 'author': author, 'link': link};
      getHttpUtils().post('lg/collect/add/json', params, success, error: error);
    } else {
      ToastUtils.showTs('收藏失败了哦');
    }
  }

  /// 获取收藏文章列表
  getCollectionArticle(int pageIndex,
      {Function success, Function error, Function empty}) {
    getHttpUtils().get('lg/collect/list/$pageIndex/json', (result) {
      if (result != null) {
        MyCollectionArticleImplEntity _bean =
            MyCollectionArticleImplEntity.fromJson(result);
        if (_bean != null && _bean.data != null) {
          List<MyCollectionArticleImplDataData> _list = _bean.data.datas;
          if (_list.isNotEmpty) {
            success(_list);
          } else {
            empty();
          }
        } else {
          error();
        }
      } else {
        error();
      }
    }, error: () {
      error();
    });
  }

  /// 在我的收藏页面  取消收藏
  cancelCollectionInMyCollectionPage(id, originId, Function success) {
    var params = {
      'id': id,
      'originId': originId ?? -1,
    };
    getHttpUtils().post('lg/uncollect/$id/json', params, (result) {
      print('the result of cancelCollectionInMyCollectionPage  is $result');
      if (result != null) {
        success();
      }
    });
  }

  /// 在我的文章列表   取消收藏
  cancelCollectionInArticleList(id, success) {
    getHttpUtils().post('lg/uncollect_originId/$id/json', {}, (result) {
      if (result != null) {
      }
      success();
    });
  }
}
