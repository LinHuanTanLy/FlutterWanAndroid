import 'package:flutter_app/common/bean/impl/project_list_child_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/project_tree_impl_entity.dart';

import 'BaseDao.dart';

/// 项目列表
class ProjectDao extends BaseDao {
  /// 获取项目列表
  Future<ProjectTreeImplEntity> getProjectTree() async {
    var result = await getHttpUtils().netFetch('/project/tree/json');
    if (result != null) {
      return ProjectTreeImplEntity.fromJson(result);
    } else {
      return new ProjectTreeImplEntity();
    }
  }

  /// 获取某个项目id下的列表数据
  Future<ProjectListChildImplEntity> getProjectList(
      String projectId, int pageIndex) async {
    var result = await getHttpUtils()
        .netFetch('/project/list/$pageIndex/json?cid=$projectId');
    if (result != null) {
      return ProjectListChildImplEntity.fromJson(result);
    } else {
      return new ProjectListChildImplEntity();
    }
  }
}
