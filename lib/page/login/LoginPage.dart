import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/user_info_impl_entity.dart';
import 'package:flutter_app/common/dao/UserDao.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/redux/AppState.dart';
import 'package:flutter_app/redux/action/UserUpdateAction.dart';
import 'package:flutter_app/utils/toast/ToastUtils.dart';
import 'package:flutter_app/widget/LyAppBar.dart';
import 'package:flutter_app/widget/ShowLoadDialog.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'LoginTopPart.dart';
import 'RegisterPage.dart';

/// 登录页面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controllerForPhone, _controllerForPsd;

  double _topHeight, _centerHeight, _bottomHeight;

  bool _ifShowPsd = true;

  UserDao _userDao;

  /// 登录
  _doLogin(Store<AppState> store) {
    showDialog(
        context: context,
        builder: (context) {
          return ShowLoadDialog(
            dismissDialog: _userDao.login(
                _controllerForPhone.text, _controllerForPsd.text, (value) {
              if (value.data != null) {
                store.dispatch(UserUpdateAction(UserInfoAction.update, value));
                Navigator.of(context).pop();
                ShowLoadDialog.popDialog(context);
              }
            }, (resultCode) {
              ShowLoadDialog.popDialog(context);
            }),
          );
        });
  }

  /// 去注册页面
  _toRegisterPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return RegisterPage();
    }));
  }

  @override
  void initState() {
    _controllerForPhone = new TextEditingController();
    _controllerForPsd = new TextEditingController();
    _userDao = new UserDao();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    _topHeight = _height * 4 / 13;
    _centerHeight = _height * 4 / 13;
    _bottomHeight = _height * 5 / 13;
    return Scaffold(
      appBar: LyAppBar.commAppBar("登录"),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              LoginTopPart(
                  height: _topHeight, title: 'LOG IN', desc: '不积跬步无以至千里'),
              Container(
                height: _centerHeight,
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
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
                        ifInputPsd: true,
                        icon: Icons.lock_open,
                        hintText: '请输入密码',
                        controller: _controllerForPsd),
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
                          onPressed: () => _doLogin(store),
                          child: Text(
                            '登录',
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
                    Container(
                      margin: const EdgeInsets.only(right: 10, top: 4),
                      child: GestureDetector(
                        child: Text(
                          '还没有账号？点这里注册',
                          style: TextStyle(
                              fontSize: 13, color: ColorConf.color929292),
                        ),
                        onTap: () {
                          _toRegisterPage(context);
                        },
                      ),
                    ),
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
  Widget _renderInputBar({
    bool ifInputPsd = false,
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
              obscureText: ifInputPsd ? _ifShowPsd : false,
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
          Offstage(
            child: Container(
              padding:
                  const EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 10),
              child: InkWell(
                child: Image.asset(
                  !_ifShowPsd
                      ? 'images/icon_eye_open.png'
                      : 'images/icon_eye_close.png',
                  width: 14,
                  height: 14,
                ),
                onTap: () {
                  setState(() {
                    _ifShowPsd = !_ifShowPsd;
                  });
                },
              ),
            ),
            offstage: !ifInputPsd,
          )
        ],
      ),
    );
  }
}
