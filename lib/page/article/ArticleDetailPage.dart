import 'package:flutter/material.dart';
import 'package:flutter_app/common/dao/CollectionDao.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/utils/toast/ToastUtils.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/// 文章详情页
class ArticleDetailPage extends StatefulWidget {
  /// 文章标题
  final String _title;

  /// 显示的url
  final String _url;

  /// 文章的id
  final int _id;

  /// 是否收藏了
  final bool _collect;

  /// 是否是外部网站  外部的话 调用的收藏接口不一样
  final bool ifExternalWebsite ;

  ArticleDetailPage(this._title, this._url, this._id, this._collect,
      {this.ifExternalWebsite=false});

  @override
  _ArticleDetailPageState createState() =>
      _ArticleDetailPageState(_title, _url, _id, ifExternalWebsite);
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final String _title;
  final String _url;
  final int _id;
  bool _collect;
  final bool ifExternalWebsite;

  /// 未收藏的颜色
  Color _colorForCollect;

  /// 操作收藏操作的dao
  CollectionDao _collectionDao = new CollectionDao();

  _ArticleDetailPageState(
    this._title,
    this._url,
    this._id,
    this.ifExternalWebsite,
  );

  FlutterWebviewPlugin flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    debugPrint('initState是不是外部网站= ${widget.ifExternalWebsite}');
    _collect = widget._collect;
    _colorForCollect =
        widget._collect ? ColorConf.colorRed : ColorConf.colorFFFFFF;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('是不是外部网站= ${widget.ifExternalWebsite}');
    return WebviewScaffold(
      withJavascript: true,
      withZoom: true,
      url: _url.replaceAll("http://", "https://"),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorConf.colorGreen,
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: Image.asset(
                'images/icon_favor.png',
                color: _colorForCollect,
                width: 20,
                height: 20,
              ),
            ),
            onTap: () {
              if (_collect) {
                if (widget.ifExternalWebsite) {
                  /// 外部网站
                  ToastUtils.showTs('请到我的收藏页面进行收藏编辑哦');
                } else {
                  /// 内部网站
                  _collectionDao.cancelCollectionInArticleList(_id, () {
                    ToastUtils.showTs('取消收藏');
                    setState(() {
                      _colorForCollect = ColorConf.colorFFFFFF;
                      _collect = false;
                    });
                  });
                }
              } else {
                if (widget.ifExternalWebsite) {
                  /// 外部网站
                  _collectionDao.collWebsite(_title, _url, (value) {
                    ToastUtils.showTs('收藏成功');
                    setState(() {
                      _colorForCollect = ColorConf.colorRed;
                      _collect = true;
                    });
                  });
                } else {
                  /// 内部网站
                  _collectionDao.collectInnerArticle(_id, (result) {
                    ToastUtils.showTs('收藏成功');
                    setState(() {
                      _colorForCollect = ColorConf.colorRed;
                      _collect = true;
                    });
                  }, (resultCode) {
                    debugPrint('the resultCode is $resultCode');
                  });
                }
              }
            },
          )
        ],
        title: Text(
          _title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorConf.colorFFFFFF,
          ),
        ),
      ),
    );
  }
}
