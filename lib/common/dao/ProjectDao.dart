import 'package:flutter_app/common/bean/impl/project_list_child_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/project_tree_impl_entity.dart';

import 'BaseDao.dart';

/// 项目列表
class ProjectDao extends BaseDao {
  /// 获取项目列表
  getProjectTree(Function success) {
    getHttpUtils().get('/project/tree/json', (value) {
      success(ProjectTreeImplEntity.fromJson(value));
    });
  }

  /// 获取某个项目id下的列表数据
  getProjectList(String projectId, int pageIndex, Function success) {
    getHttpUtils().get('/project/list/$pageIndex/json?cid=$projectId',
        (result) {
      success(ProjectListChildImplEntity.fromJson(result));
    });
  }
}
