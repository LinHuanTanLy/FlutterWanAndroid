import 'package:flutter/material.dart';
import 'package:flutter_app/conf/ColorConf.dart';

class LyWidget {
  static Widget getImageView(String url) {
    Image image = Image.network(url);
    final ImageStream stream = image.image.resolve(ImageConfiguration.empty);
//    stream.addListener(ImageStreamListener());
    stream.addListener(
      ImageStreamListener((imageInfo, bool) {}, onChunk: (event) {},
          onError: (e, stackTrace) {
        image = Image.asset('images/empty_data.png');
      }),
    );
    return image;
  }

  /// 加载页面
  static Widget loadingWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new CircularProgressIndicator(
          strokeWidth: 1.0,
          backgroundColor: Colors.blue,
          // value: 0.2,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            '努力加载中...',
            style: TextStyle(fontSize: 14, color: ColorConf.color929292),
          ),
        )
      ],
    );
  }

  /// 空视图
  static Widget emptyWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('images/empty_data.png',width: 120,fit: BoxFit.fitWidth,),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            '暂无数据...',
            style: TextStyle(fontSize: 14, color: ColorConf.color929292),
          ),
        )
      ],
    );
  }
}
