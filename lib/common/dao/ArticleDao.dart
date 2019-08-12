import 'package:flutter_app/common/bean/impl/article_list_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/banner_bean_impl_entity.dart';

import 'BaseDao.dart';

class ArticleDao extends BaseDao {
  /// 获取banner
  getBanner(Function success) {
    getHttpUtils().get('banner/json', (result) {
      success(BannerBeanImplEntity.fromJson(result));
    });
  }

  /// 获取文章列表
  getArticleTop(Function success, {int page}) {
    getHttpUtils().get('article/list/${page ?? 0}/json', (value) {
      success(ArticleListImplEntity.fromJson(value));
    });
  }

  /// 获取本地的图片
  List<String> getProjectsIconsList() {
    List<String> _list = [];
    for (int i = 16; i < 32; i++) {
      _list.add('images/ani_$i.png');
    }
    return _list;
  }
}
