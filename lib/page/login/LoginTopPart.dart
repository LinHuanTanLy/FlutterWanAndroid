import 'package:flutter_web/material.dart';
import 'package:flutter_app/conf/ColorConf.dart';

/// 登录模块的上方模块
class LoginTopPart extends StatefulWidget {
  final double height;
  final String title;
  final String desc;

  const LoginTopPart({Key key, this.height, this.title, this.desc}) : super(key: key);


  @override
  _LoginTopPartState createState() => _LoginTopPartState(height,title,desc);
}

class _LoginTopPartState extends State<LoginTopPart> {
  final double height;
  final String title;
  final String desc;

  _LoginTopPartState(this.height, this.title, this.desc);
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: height,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontSize: 46,
                color: ColorConf.color000000,
                wordSpacing: 4,
                fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              desc,
              style: TextStyle(
                  fontSize: 14,
                  color: ColorConf.color929292,
                  fontStyle: FontStyle.italic),
            ),
          )
        ],
      ),
    );
  }
}
