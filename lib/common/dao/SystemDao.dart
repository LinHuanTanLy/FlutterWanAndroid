import 'package:flutter_app/common/bean/impl/article_list_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/blog_list_impl_entity.dart';
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

  /// 获取体系下的文章列表
  Future<ArticleListImplEntity> getArticleTop({int page, String cid}) async {
    var result = await getHttpUtils()
        .netFetch('article/list/${page ?? 0}/json?cid=$cid');
    if (result != null) {
      return ArticleListImplEntity.fromJson(result);
    } else {
      return new ArticleListImplEntity();
    }
  }

  /// 获取推荐博客列表
  Future<BlogListImplEntity> getBlogList() async {
    var result = await getHttpUtils().netFetch('friend/json');
    if (result != null) {
      return BlogListImplEntity.fromJson(result);
    } else {
      return new BlogListImplEntity();
    }
  }
}
