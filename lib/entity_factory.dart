import 'package:flutter_app/common/bean/impl/article_list_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/banner_bean_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/system_tree_impl_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "ArticleListImplEntity") {
      return ArticleListImplEntity.fromJson(json) as T;
    } else if (T.toString() == "BannerBeanImplEntity") {
      return BannerBeanImplEntity.fromJson(json) as T;
    } else if (T.toString() == "SystemTreeImplEntity") {
      return SystemTreeImplEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}