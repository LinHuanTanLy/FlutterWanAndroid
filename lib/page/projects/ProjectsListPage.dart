import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/project_tree_impl_entity.dart';
import 'package:flutter_app/common/dao/ProjectDao.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/page/projects/ProjectsChildPage.dart';
import 'package:flutter_app/widget/LyAppBar.dart';

class ProjectsListPage extends StatefulWidget {
  final int defIndex;

  ProjectsListPage(this.defIndex);

  @override
  _ProjectsListPageState createState() => _ProjectsListPageState(defIndex);
}

class _ProjectsListPageState extends State<ProjectsListPage>
    with TickerProviderStateMixin {
  ProjectDao _projectDao;
  List<ProjectTreeImplData> _list = [];
  TabController _tabController;
  final int defIndex;

  _ProjectsListPageState(this.defIndex);

  @override
  void initState() {
    _projectDao = new ProjectDao();
    super.initState();

    _projectDao.getProjectTree().then((value) {
      setState(() {
        if (value.data != null) {
          _list.addAll(value.data);
          _tabController = new TabController(length: _list.length, vsync: this);
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_tabController == null)
      _tabController = new TabController(length: _list.length, vsync: this);
    return Scaffold(
      appBar: LyAppBar.commAppBar('更多项目', bottom: _initBottomTabBar()),
      body: TabBarView(
          controller: _tabController,
          children: _list.map((e) {
            return Container(
              child: ProjectsChildPage(e.id.toString()),
            );
          }).toList()),
    );
  }

  /// 初始化bottom Widget
  TabBar _initBottomTabBar() {
    return TabBar(
      isScrollable: true,
      unselectedLabelColor: ColorConf.colorF5F5F5,
      labelColor: ColorConf.colorFFFFFF,
      labelStyle: TextStyle(fontSize: 15),
      unselectedLabelStyle: TextStyle(fontSize: 15),
      tabs: _initTabView(),
      controller: _tabController,
    );
  }

  /// 初始化tab里面的子Widget
  List<Widget> _initTabView() {
    return _list
        .map((e) => Tab(
              text: e.name,
            ))
        .toList();
  }
}
