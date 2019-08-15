import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/my_collection_article_impl_entity.dart';
import 'package:flutter_app/common/dao/CollectionDao.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/widget/LyAppBar.dart';
import 'package:flutter_app/widget/ProjectWidget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';

/// 收藏文章列表
class CollectionInnerPage extends StatefulWidget {
  @override
  _CollectionInnerPageState createState() => _CollectionInnerPageState();
}

class _CollectionInnerPageState extends State<CollectionInnerPage> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  CollectionDao _collectionDao = new CollectionDao();

  List<MyCollectionArticleImplDataData> _list = [];
  int _currPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadList();
  }

  _loadList() {
    _collectionDao.getCollectionArticle(0, success: (result) {
      if (_currPageIndex == 0) _list.clear();
      setState(() {
        _list.addAll(result);
      });
    }, error: () {}, empty: () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: LyAppBar.commAppBar('收藏文章'),
        body: EasyRefresh(
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
              _currPageIndex = 0;
              _loadList();
            });
          },
          loadMore: () async {
            await new Future.delayed(const Duration(seconds: 1), () {
              _currPageIndex++;
              _loadList();
            });
          },
          child: ListView.builder(
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(index.toString()),
                  onDismissed: (id) {
                    _deleteItem(id, index);
                  },
                  background: Container(
                    padding: const EdgeInsets.only(right: 30),
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: Text(
                      '滑动取消收藏',
                      style:
                          TextStyle(fontSize: 16, color: ColorConf.colorFFFFFF),
                    ),
                  ),
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      ProjectWidget.renderListViewCollectionItem(
                          _list[index], () {}),
                      Divider(),
                    ],
                  )),
                );
              },
              itemCount: _list.length),
        ));
  }

  /// 删除item
  _deleteItem(id, index) {
    _list.removeAt(index);
  }
}
