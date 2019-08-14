import 'package:flutter/material.dart';
import 'package:flutter_app/common/dao/CollectionDao.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/utils/toast/ToastUtils.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/// 文章详情页
class ArticleDetailPage extends StatefulWidget {
  final String _title;
  final String _url;

  ArticleDetailPage(this._title, this._url);

  @override
  _ArticleDetailPageState createState() =>
      _ArticleDetailPageState(_title, _url);
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final String _title;
  final String _url;
  CollectionDao _collectionDao = new CollectionDao();
  _ArticleDetailPageState(this._title, this._url);

  FlutterWebviewPlugin flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      withJavascript: true,
      withZoom: true,
      url: _url.replaceAll("http://", "https://"),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: Image.asset(
                'images/icon_favor.png',
                color: ColorConf.colorFFFFFF,
                width: 20,
                height: 20,
              ),
            ),
            onTap: () {
              _collectionDao.collInner('1165', (result) {
                debugPrint('the result is $result');
                ToastUtils.showTs('收藏成功');
              }, (resultCode) {
                debugPrint('the resultCode is $resultCode');
              });
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
