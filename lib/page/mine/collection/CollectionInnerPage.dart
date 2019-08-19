import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/my_collection_article_impl_entity.dart';
import 'package:flutter_app/common/dao/CollectionDao.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/page/article/ArticleDetailPage.dart';
import 'package:flutter_app/widget/LyAppBar.dart';
import 'package:flutter_app/widget/LyWidget.dart';
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

  bool isEmpty = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadList();
  }

  _loadList() {
    _collectionDao.getCollectionArticle(_currPageIndex, success: (result) {
      setState(() {
        isLoading = false;
      });
      if (_currPageIndex == 0) _list.clear();
      setState(() {
        _list.addAll(result);
      });
    }, error: () {
      debugPrint('error');
      setState(() {
        isLoading = false;
      });
    }, empty: () {
      debugPrint('empty');
      setState(() {
        isLoading = false;
        isEmpty = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: LyAppBar.commAppBar('收藏文章'),
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Offstage(
              child: LyWidget.loadingWidget(),
              offstage: !isLoading,
            ),
            Offstage(
              child: LyWidget.emptyWidget(),
              offstage: !isEmpty,
            ),
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
              child: _renderListView(),
            )
          ],
        ));
  }

  _renderListView() {
    return ListView.builder(
        shrinkWrap: true,
        primary: true,
        itemBuilder: (context, index) {
          var item = _list[index];
          debugPrint('the key is ${index.toString()}');
          return Dismissible(
            key: Key(UniqueKey().toString()),
            confirmDismiss: (DismissDirection direction) async {
              final bool res = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: Text(
                        "注意",
                        style: TextStyle(
                            fontSize: 16, color: ColorConf.color000000),
                      ),
                      content: const Text("您是否要取消收藏这个文章呢？"),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                              _deleteItem(item.id, item.originId, index);
                            },
                            child: Text(
                              "是的",
                              style: TextStyle(
                                  fontSize: 14, color: ColorConf.colorGreen),
                            )),
                        FlatButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(
                            "我不",
                            style: TextStyle(
                                fontSize: 14, color: ColorConf.color48586D),
                          ),
                        )
                      ],
                    );
                  });
              return res;
            },
            background: Container(
              padding: const EdgeInsets.only(right: 30),
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Text(
                '滑动取消收藏',
                style: TextStyle(fontSize: 16, color: ColorConf.colorFFFFFF),
              ),
            ),
            child: Container(
                child: Column(
              children: <Widget>[
                InkWell(
                  child: ProjectWidget.renderListViewCollectionItem(item, () {
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (BuildContext context) {
                      return ArticleDetailPage(
                          item.title, item.link, item.id, true);
                    }));
                  }),
                  onTap: () {},
                ),
                Divider(),
              ],
            )),
          );
        },
        itemCount: _list.length);
  }

  /// 删除item
  _deleteItem(id, originId, index) {
    _collectionDao.cancelCollectionInMyCollectionPage(id, originId, () {
      _list.removeAt(index);
      debugPrint('after delete,the length of _list ${_list.length}');
    });
  }
}
