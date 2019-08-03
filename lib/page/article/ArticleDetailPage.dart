import 'package:flutter/material.dart';
import 'package:flutter_app/widget/LyAppBar.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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

  _ArticleDetailPageState(this._title, this._url);

  FlutterWebviewPlugin flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      withJavascript: true,
      withZoom: true,
      url: _url.replaceAll("http://", "https://"),
      appBar: LyAppBar.commAppBar(_title),
    );
  }
}
