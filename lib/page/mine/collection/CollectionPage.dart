import 'package:flutter/material.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/widget/LyAppBar.dart';

/// 收藏页面
class CollectionPage extends StatefulWidget {
  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LyAppBar.commAppBar('我的收藏'),
      body: Column(
        children: <Widget>[
          _renderCollectItem('文章列表'),
          Divider(
            height: 8,
          ),
          _renderCollectItem('网站列表'),
          Divider(
            height: 8,
          ),
        ],
      ),
    );
  }

  /// 渲染item子页面
  Widget _renderCollectItem(title) {
    return InkWell(
      child: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 16, color: ColorConf.color48586D),
            ),
            Expanded(
              child: Container(
                child: Image.asset('images/right_arrow.png',
                    width: 20, height: 20),
                alignment: Alignment.centerRight,
              ),
            )
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
