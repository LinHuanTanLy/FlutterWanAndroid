import 'package:flutter_app/common/bean/impl/project_list_child_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/search_hot_impl_entity.dart';
import 'package:flutter_app/utils/toast/ToastUtils.dart';

import 'BaseDao.dart';

///搜索的dao
class SearchDao extends BaseDao {
  /// 搜索热词
  getSearchHot(Function success) {
    getHttpUtils().get('hotkey/json', (result) {
      if (result != null) {
        SearchHotImplEntity _entity = SearchHotImplEntity.fromJson(result);
        success(_entity);
      }
    });
  }

  /// 搜索
  searchArticle(int pageIndex, String keyWord, Function success) {
    var params = {
      'k': keyWord,
    };
    getHttpUtils().post('article/query/$pageIndex/json', params, (result) {
      if (result != null) {
        ProjectListChildImplEntity _entity =
            ProjectListChildImplEntity.fromJson(result);
        if (_entity.data != null && _entity.data.datas.isNotEmpty) {
          success(_entity.data.datas);
        } else {
          ToastUtils.showTs('暂无更多数据');
        }
      }
    });
  }
}
