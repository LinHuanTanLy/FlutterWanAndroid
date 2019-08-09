import 'package:flutter_app/common/bean/impl/article_list_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/banner_bean_impl_entity.dart';

import 'BaseDao.dart';

class ArticleDao extends BaseDao {
  /// 获取banner
  Future<BannerBeanImplEntity> getBanner() async {
    var result = await getHttpUtils().netFetch('banner/json');
    if (result != null) {
      return BannerBeanImplEntity.fromJson(result);
    } else {
      return new BannerBeanImplEntity();
    }
  }

  /// 获取文章列表
  Future<ArticleListImplEntity> getArticleTop({int page}) async {
    var result =
        await getHttpUtils().netFetch('article/list/${page ?? 0}/json');
    if (result != null) {
      return ArticleListImplEntity.fromJson(result);
    } else {
      return new ArticleListImplEntity();
    }
  }

  List<String> getProjectsIconsList() {
    List<String> _list = [];
    for (int i = 16; i < 32; i++) {
      _list.add('images/ani_$i.png');
    }
    return _list;
  }
}
