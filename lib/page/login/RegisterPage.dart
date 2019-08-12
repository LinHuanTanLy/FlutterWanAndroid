import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/user_info_impl_entity.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/redux/AppState.dart';
import 'package:flutter_app/redux/action/AppAction.dart';
import 'package:flutter_app/redux/action/UserUpdateAction.dart';
import 'package:flutter_app/widget/LyAppBar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'LoginTopPart.dart';

/// 注册页面
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  double _topHeight, _centerHeight, _bottomHeight;
  TextEditingController _controllerForPhone,
      _controllerForPsd,
      _controllerForPasConfirm;

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    _topHeight = _height * 3 / 13;
    _centerHeight = _height * 5 / 13;
    _bottomHeight = _height * 5 / 13;
    return Scaffold(
      appBar: LyAppBar.commAppBar('注册页面'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            LoginTopPart(
                height: _topHeight, title: 'REGISTER', desc: '不积小流无以成江海'),
            Container(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
              height: _centerHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      hintText: '请输入用户密码',
                      controller: _controllerForPhone),
                  Divider(
                    height: 4,
                  ),
                  _renderInputBar(
                      icon: Icons.lock_open,
                      hintText: '请重复用户密码',
                      controller: _controllerForPasConfirm),
                  Divider(
                    height: 4,
                  ),
                ],
              ),
            ),
            Container(
              height: _bottomHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  StoreConnector<AppState, Store<AppState>>(
                    converter: (store) => store,
                    builder: (context, Store<AppState> store) {
                      return MaterialButton(
                        minWidth: 300,
                        onPressed: () {
                          var userInfo = new UserInfoImplEntity(
                              data: UserInfoImplData(username: "sfdsd"));
                          store.dispatch(UserUpdateAction(
                              UserInfoAction.update, userInfo));
                        },
                        child: Text(
                          '注册',
                          style: TextStyle(
                              fontSize: 15, color: ColorConf.colorFFFFFF),
                        ),
                        color: ColorConf.colorGreen,
                        textColor: ColorConf.colorFFFFFF,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(50)),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 渲染输入框布局
  Widget _renderInputBar({
    icon,
    hintText,
    inputType,
    controller,
  }) {
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
          ),
        ],
      ),
    );
  }
}
