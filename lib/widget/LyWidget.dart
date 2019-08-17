import 'package:flutter/material.dart';
import 'package:flutter_app/conf/ColorConf.dart';

class LyWidget {
  static Widget getImageView(String url){
    Image image = Image.network(url);
    final ImageStream stream = image.image.resolve(ImageConfiguration.empty);
//    stream.addListener(ImageStreamListener());
//    stream.addLis0tener();
    return image;
  }


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
}
