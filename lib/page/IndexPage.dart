import 'package:flutter/material.dart';
import 'package:banner/banner.dart';
import 'package:flutter_app/common/bean/impl/article_list_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/banner_bean_impl_entity.dart';
import 'package:flutter_app/common/dao/ArticleDao.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/utils/comm/StringUtils.dart';
import 'package:flutter_app/widget/ArticleWidget.dart';
import 'package:flutter_app/widget/LyAppBar.dart';

import 'article/ArticleDetailPage.dart';
import 'article/ArticleListPage.dart';

class _IndexPageState extends State<IndexPage>  with AutomaticKeepAliveClientMixin{
  ArticleDao _articleDao;

  BannerBeanImplEntity _bannerBeanImplEntity;
  ArticleListImplEntity _articleTopImplEntity;

  @override
  void initState() {
    _articleDao = new ArticleDao();
    _articleDao.getBanner().then((value) {
      setState(() {
        _bannerBeanImplEntity = value;
      });
    });
    _articleDao.getArticleTop().then((value) {
      setState(() {
        debugPrint('the value is $value');
        _articleTopImplEntity = value;
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

  @override
  Widget build(BuildContext context) {
    super.build(context);//必须添加
    return Scaffold(
      appBar: _initAppBar(),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return index != 0 ? _renderCommLine() : _renderTopLine();
        },
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _renderBanner();
          } else {
            return _renderListViewItem(context, index - 1);
          }
        },
        itemCount: _articleTopImplEntity != null
            ? _articleTopImplEntity.data.datas.length + 1
            : 1,
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
  Widget _renderTopLine() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Row(
                children: <Widget>[
                  Icon(
                    Icons.whatshot,
                    color: Colors.green,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 4),
                    child: Text(
                      '文章列表',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                  )
                ],
              )),
              InkWell(
                child: Text(
                  '更多文章',
                  style: TextStyle(fontSize: 13, color: ColorConf.color929292),
                ),
                onTap: () {
                  _toMoreArticle();
                },
              ),
              Icon(
                Icons.chevron_right,
                color: ColorConf.color929292,
              )
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  /// 渲染listView item
  Widget _renderListViewItem(context, int index) {
    var data = _articleTopImplEntity.data.datas[index];
    return ArticleWidget.renderListViewItem(context, data);
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
