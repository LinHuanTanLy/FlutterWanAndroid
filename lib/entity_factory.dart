import 'common/bean/impl//article_list_impl_entity.dart';
import 'common/bean/impl//banner_bean_impl_entity.dart';
import 'common/bean/impl//blog_list_impl_entity.dart';
import 'common/bean/impl//project_list_child_impl_entity.dart';
import 'common/bean/impl//project_tree_impl_entity.dart';
import 'common/bean/impl//system_tree_impl_entity.dart';
import 'common/bean/impl//user_info_impl_entity.dart';
import 'common/bean/impl//web_list_impl_entity.dart';
import 'common/bean/impl//we_chat_pub_child_list_impl_entity.dart';
import 'common/bean/impl//we_chat_pub_list_impl_entity.dart';

import 'common/bean/impl/my_collection_article_impl_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "ArticleListImplEntity") {
      return ArticleListImplEntity.fromJson(json) as T;
    } else if (T.toString() == "BannerBeanImplEntity") {
      return BannerBeanImplEntity.fromJson(json) as T;
    } else if (T.toString() == "BlogListImplEntity") {
      return BlogListImplEntity.fromJson(json) as T;
    } else if (T.toString() == "MyCollectionArticleImplEntity") {
      return MyCollectionArticleImplEntity.fromJson(json) as T;
    } else if (T.toString() == "ProjectListChildImplEntity") {
      return ProjectListChildImplEntity.fromJson(json) as T;
    } else if (T.toString() == "ProjectTreeImplEntity") {
      return ProjectTreeImplEntity.fromJson(json) as T;
    } else if (T.toString() == "SystemTreeImplEntity") {
      return SystemTreeImplEntity.fromJson(json) as T;
    } else if (T.toString() == "UserInfoImplEntity") {
      return UserInfoImplEntity.fromJson(json) as T;
    } else if (T.toString() == "WebListImplEntity") {
      return WebListImplEntity.fromJson(json) as T;
    } else if (T.toString() == "WeChatPubChildListImplEntity") {
      return WeChatPubChildListImplEntity.fromJson(json) as T;
    } else if (T.toString() == "WeChatPubListImplEntity") {
      return WeChatPubListImplEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
