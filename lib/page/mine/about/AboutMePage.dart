import 'package:flutter/material.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/// 关于我
class AboutMePage extends StatefulWidget {


  @override
  _AboutMePageState createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  FlutterWebviewPlugin flutterWebViewPlugin = FlutterWebviewPlugin();

  String _url='https://github.com/LinHuanTanLy';

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
        backgroundColor: ColorConf.colorGreen,
        centerTitle: true,
        title: Text(
          '关于我',
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
