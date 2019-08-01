import 'package:flutter_app/common/bean/impl/article_list_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/banner_bean_impl_entity.dart';
import 'package:flutter_app/utils/http/HttpUtils.dart';

class ArticleDao {
  HttpUtils httpUtils;

  ArticleDao() {
    httpUtils = new HttpUtils();
  }

  /// 获取banner
  Future<BannerBeanImplEntity> getBanner() async {
    var result = await httpUtils.netFetch('banner/json');
    if (result != null) {
      return BannerBeanImplEntity.fromJson(result);
    } else {
      return new BannerBeanImplEntity();
    }
  }

  Future<ArticleListImplEntity> getArticleTop() async {
    var result = await httpUtils.netFetch('article/list/0/json');
    if (result != null) {
      return ArticleListImplEntity.fromJson(result);
    } else {
      return new ArticleListImplEntity();
    }
  }
}
