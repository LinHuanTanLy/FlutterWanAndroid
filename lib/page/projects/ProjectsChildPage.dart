import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/project_list_child_impl_entity.dart';
import 'package:flutter_app/common/dao/ProjectDao.dart';
import 'package:flutter_app/page/article/ArticleDetailPage.dart';
import 'package:flutter_app/widget/LyWidget.dart';
import 'package:flutter_app/widget/ProjectWidget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';

///  子页面  项目列表
class ProjectsChildPage extends StatefulWidget {
  final String projectId;

  ProjectsChildPage(this.projectId);

  @override
  _ProjectsChildPageState createState() => _ProjectsChildPageState(projectId);
}

class _ProjectsChildPageState extends State<ProjectsChildPage>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  final String projectId;
  int _pageIndex = 0;
  ProjectDao _projectDao;
  List<ProjectListChildImplDataData> _list = [];

  _ProjectsChildPageState(this.projectId);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _projectDao = new ProjectDao();
    _loadList();
    super.initState();
  }

  _loadList() {
    _projectDao.getProjectList(projectId, _pageIndex).then((value) {
      if (value.data != null && value.data.datas != null) {
        setState(() {
          if (_pageIndex == 0) {
            _list.clear();
            _list.addAll(value.data.datas);
          } else {
            _list.addAll(value.data.datas);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); //必须添加
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        EasyRefresh(
          key: _easyRefreshKey,
          behavior: ScrollOverBehavior(),
          refreshHeader: MaterialHeader(
            key: _headerKey,
          ),
          refreshFooter: ClassicsFooter(
            key: _footerKey,
            bgColor: Colors.transparent,
            textColor: Colors.black87,
            moreInfoColor: Colors.black54,
            showMore: true,
          ),
          onRefresh: () async {
            await new Future.delayed(const Duration(seconds: 1), () {
              _pageIndex = 0;
              _loadList();
            });
          },
          loadMore: () async {
            await new Future.delayed(const Duration(seconds: 1), () {
              _pageIndex++;
              _loadList();
            });
          },
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 1,
              );
            },
            itemBuilder: (context, index) {
              return ProjectWidget.renderListViewItem(_list[index], () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return new ArticleDetailPage(
                      _list[index].title, _list[index].projectLink);
                }));
              });
            },
            itemCount: _list.length,
          ),
        ),
        Offstage(
          child: LyWidget.loadingWidget(),
          offstage: _list.isNotEmpty,
        )
      ],
    );
  }
}
