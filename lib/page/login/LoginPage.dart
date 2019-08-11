import 'package:flutter/material.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/widget/LyAppBar.dart';

/// 登录页面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controllerForPhone, _controllerForPsd;

  double _topHeight, _centerHeight, _bottomHeight;

  @override
  void initState() {
    _controllerForPhone = new TextEditingController();
    _controllerForPsd = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    _topHeight = _height * 4 / 14;
    _centerHeight = _height * 5 / 14;
    _bottomHeight = _height * 5 / 14;
    debugPrint('_topHeight is  $_topHeight');
    debugPrint('_bottomHeight is  $_bottomHeight');
    return Scaffold(
      appBar: LyAppBar.commAppBar("登录"),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: _topHeight,
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'LOG IN',
                      style: TextStyle(
                          fontSize: 46,
                          color: ColorConf.color000000,
                          wordSpacing: 4,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '不积跬步无以至千里',
                      style: TextStyle(
                          fontSize: 14,
                          color: ColorConf.color929292,
                          fontStyle: FontStyle.italic),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: _centerHeight,
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _renderInputBar(
                        icon: Icons.phone_iphone,
                        hintText: '请输入用户名',
                        controller: _controllerForPhone),
                    Divider(
                      height: 4,
                    ),
                    _renderInputBar(
                        icon: Icons.lock_open,
                        hintText: '请输入用户名',
                        controller: _controllerForPhone),
                    Divider(
                      height: 4,
                    ),
                  ],
                ),
              ),
              Container(
                height: _bottomHeight,
                child: Column(
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 300,
                      onPressed: () {},
                      child: Text('登录',style: TextStyle(fontSize: 15,color: ColorConf.colorFFFFFF),),
                      color: ColorConf.colorGreen,
                      textColor: ColorConf.colorFFFFFF,
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.circular(50)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 渲染输入框布局
  Widget _renderInputBar({icon, hintText, inputType, controller}) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          Icon(
            icon ?? Icons.phone_iphone,
            color: ColorConf.color929292,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    left: 10, right: 10, top: 6, bottom: 6),
                hintText: hintText,
                hintStyle:
                    TextStyle(fontSize: 13, color: ColorConf.color929292),
                border: InputBorder.none,
              ),
            ),
            flex: 1,
          )
        ],
      ),
    );
  }
}
