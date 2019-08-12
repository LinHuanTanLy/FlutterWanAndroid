import 'package:flutter_app/common/bean/impl/article_list_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/blog_list_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/system_tree_impl_entity.dart';

import 'BaseDao.dart';

class SystemDao extends BaseDao {
  /// 获取体系列表
  getSystemTree(Function success) {
    getHttpUtils().get('tree/json', (result) {
      success(SystemTreeImplEntity.fromJson(result));
    });
  }

  /// 获取体系下的文章列表
   getArticleTop(Function success,{int page, String cid}) async {
   getHttpUtils()
        .get('article/list/${page ?? 0}/json?cid=$cid',(result){
          success(ArticleListImplEntity.fromJson(result));
    });
  }

  /// 获取推荐博客列表
   getBlogList(Function success)  {
     getHttpUtils().get('friend/json',(result){
      success(BlogListImplEntity.fromJson(result));
    });
  }
}
