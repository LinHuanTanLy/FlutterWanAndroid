import 'package:flutter/material.dart';
import 'package:banner/banner.dart';
import 'package:flutter_app/common/bean/impl/article_list_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/banner_bean_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/project_tree_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/we_chat_pub_list_impl_entity.dart';
import 'package:flutter_app/common/dao/ArticleDao.dart';
import 'package:flutter_app/common/dao/ProjectDao.dart';
import 'package:flutter_app/common/dao/WeChatPubDao.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/page/projects/ProjectsListPage.dart';
import 'package:flutter_app/widget/ArticleWidget.dart';
import 'package:flutter_app/widget/LyAppBar.dart';

import 'article/ArticleDetailPage.dart';
import 'article/ArticleListPage.dart';
import 'index/IndexWeChatPubPart.dart';

class _IndexPageState extends State<IndexPage>
    with AutomaticKeepAliveClientMixin {
  ArticleDao _articleDao;
  ProjectDao _projectDao;


  BannerBeanImplEntity _bannerBeanImplEntity;
  ArticleListImplEntity _articleTopImplEntity;
  ProjectTreeImplEntity _projectTreeImplEntity;


  @override
  void initState() {
    _articleDao = new ArticleDao();
    _projectDao = new ProjectDao();

    _articleDao.getBanner().then((value) {
      setState(() {
        _bannerBeanImplEntity = value;
      });
    });
    _articleDao.getArticleTop().then((value) {
      setState(() {
        debugPrint('the value is ${value.data.datas.length}');
        _articleTopImplEntity = value;
      });
    });
    _projectDao.getProjectTree().then((value) {
      setState(() {
        debugPrint('the value is $value');
        _projectTreeImplEntity = value;
      });
    });
    super.initState();
  }

  /// 查看更多文章
  _toMoreArticle() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new ArticleListPage();
    }));
  }

  ///  查看更多项目
  _toMoreProjects({int index}) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new ProjectsListPage(index);
    }));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); //必须添加
    return Scaffold(
      appBar: _initAppBar(),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
//          return index != 1 ? _renderCommLine() : _renderTopLine();
          if (index == 0) {
            return _renderParticularLine("项目列表",
                rightMsg: '更多项目',
                icons: 'images/projects.png',
                isHideMore: false,
                callBack: _toMoreProjects);
          } else if (index == 1) {
            return _renderParticularLine(
              "公众号列表",
              isHideMore: false,
              callBack: _toMoreArticle,
              icons: 'images/wechat_public.png',
            );
          } else if (index == 2) {
            return _renderParticularLine("文章列表",
                isHideMore: false,
                callBack: _toMoreArticle,
                icons: 'images/fire.png');
          } else {
            return _renderCommLine();
          }
        },
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _renderBanner();
          } else if (index == 1) {
            return _renderProjectList();
          } else if (index == 2) {
            return IndexWeChatPubPart();
          } else {
            return _renderListViewItem(context, index - 3);
          }
        },
        itemCount: _articleTopImplEntity != null
            ? _articleTopImplEntity.data.datas.length + 3
            : 3,
      ),
    );
  }

  ///  普通的分割线
  Widget _renderCommLine() {
    return Container(
      height: 10,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      color: ColorConf.colorF0F0F0,
    );
  }

  /// 第一条的分割线
  Widget _renderParticularLine(String title,
      {String rightMsg, bool isHideMore = true, icons, Function callBack}) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(
                  icons ?? 'images/wechat_public.png',
                  width: 22,
                  height: 22,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 4, right: 4),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                ),
                Image.asset(
                  'images/right_arrow.png',
                  width: 12,
                  height: 12,
                )
              ],
            ),
            Divider(),
          ],
        ),
      ),
      onTap: callBack,
    );
  }

  /// 渲染listView item
  Widget _renderListViewItem(context, int index) {
    var data = _articleTopImplEntity.data.datas[index];
    return ArticleWidget.renderListViewItem(context, data);
  }

  /// 渲染项目列表
  Widget _renderProjectList() {
    var list =
        _projectTreeImplEntity != null ? _projectTreeImplEntity.data : [];
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
      child: Card(
        elevation: 0.2,
        child: Container(
          child: GridView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: list.length >= 8 ? 8 : list.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  childAspectRatio: 1),
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          _articleDao.getProjectsIconsList()[index],
                          width: 30,
                          height: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            '${list[index].name}',
                            style: TextStyle(
                                fontSize: 12, color: ColorConf.color48586D),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    _toMoreProjects(index: index);
                  },
                );
              }),
        ),
      ),
    );
  }


  /// 渲染banner
  Widget _renderBanner() {
    return new Container(
      height: 180,
      child: new BannerView(
        data: _bannerBeanImplEntity != null ? _bannerBeanImplEntity.data : [],
        buildShowView: (index, data) {
          return Container(
            child: Image.network(
              data.imagePath,
              fit: BoxFit.fitWidth,
            ),
          );
        },
        onBannerClickListener: (index, data) {
          Navigator.push(context,
              new MaterialPageRoute(builder: (BuildContext context) {
            return new ArticleDetailPage(data.title, data.url);
          }));
        },
      ),
    );
  }

  AppBar _initAppBar() {
    return LyAppBar.searchAppBar();
  }

  @override
  bool get wantKeepAlive => true;
}

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}
