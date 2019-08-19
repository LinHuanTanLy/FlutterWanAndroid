import 'package:flutter_app/common/bean/impl/my_collection_article_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/web_list_impl_entity.dart';
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

  /// 收藏网站
  collWebsite(String name, String link, Function success) {
    var params = {
      'name': name,
      'link': link,
    };
    getHttpUtils().post('lg/collect/addtool/json', params, success);
  }

  /// 获取我的收藏网址列表
  myWebSiteList(Function success) {
    getHttpUtils().get("/lg/collect/usertools/json", (value) {
      if (value != null) {
        WebListImplEntity _webList = WebListImplEntity.fromJson(value);
        success(_webList);
      }
    });
  }

  /// 删除我的收藏网站
  deleteMyWebSite(int id, Function success) {
    var params = {
      'id': id,
    };
    getHttpUtils().post('lg/collect/deletetool/json', params, (value) {
      success();
    });
  }

  /// 编辑我收藏的网站
  editMyWebSite(int id, String name, String link, Function success) {
    var params = {
      'id': id,
      'name': name,
      'link': link,
    };
    getHttpUtils().post('lg/collect/updatetool/json', params, (value) {
      print('value is $value');
      success();
    });
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
      if (result != null) {}
      success();
    });
  }
}
