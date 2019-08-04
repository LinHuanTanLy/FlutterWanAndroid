import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/article_list_impl_entity.dart';
import 'package:flutter_app/common/dao/ArticleDao.dart';
import 'package:flutter_app/widget/ArticleWidget.dart';
import 'package:flutter_app/widget/LyAppBar.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';

class ArticleListPage extends StatefulWidget {
  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  ArticleDao _articleDao;

  List<ArticleListImplDataData> _articleList = [];

  int _currPage = 0;

  @override
  void initState() {
    _articleDao = new ArticleDao();
    _loadList();
    super.initState();
  }

  _loadList() {
    _articleDao.getArticleTop(page: _currPage).then((value) {
      setState(() {
        if (_currPage == 0) {
          _articleList.clear();
          _articleList.addAll(value.data.datas);
        } else {
          _articleList.addAll(value.data.datas);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LyAppBar.commAppBar('更多文章'),
      body: Center(
        child: EasyRefresh(
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
                _currPage = 1;
                _loadList();
              });
            },
            loadMore: () async {
              await new Future.delayed(const Duration(seconds: 1), () {
                _currPage++;
                _loadList();
              });
            },
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ArticleWidget.renderListViewItem(
                      context, _articleList[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                itemCount: _articleList.length)),
      ),
    );
  }
}
