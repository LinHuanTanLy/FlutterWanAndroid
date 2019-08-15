import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/page/MinePage.dart';
import 'package:flutter_app/page/SystemPage.dart';
import 'package:flutter_app/redux/AppState.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'common/bean/impl/user_info_impl_entity.dart';
import 'page/IndexPage.dart';
import 'redux/action/UserUpdateAction.dart';
import 'utils/cache/CacheKey.dart';
import 'utils/cache/SpUtils.dart';
import 'utils/http/HttpUtils.dart';

void main() {
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  final store = Store<AppState>(reducer, initialState: AppState.initState());
  SpUtils.getSpString(CacheKey.cacheCookie).then((value) {
    if (value != null && value.isNotEmpty) {
      HttpUtils().cookie = value;
    }
  });
  SpUtils.getSpString(CacheKey.cacheUserInfo).then((value) {
    if (value != null) {
      UserInfoImplEntity _userInfo =
          UserInfoImplEntity.fromJson(json.decode(value));
      store.dispatch(UserUpdateAction(UserInfoAction.update, _userInfo));
    }
  });
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currIndex = 0;
  static const double ICON_WIDTH = 22;
  static const double ICON_WIDTH_ACTIVE = 24;
  IndexedStack _listContent;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _initContainer();
    return Scaffold(
      body: _listContent,
      bottomNavigationBar: BottomNavigationBar(
        items: _initBottom(),
        currentIndex: _currIndex,
        unselectedFontSize: 10,
        selectedFontSize: 12,
        iconSize: 16,
        onTap: (index) {
          setState(() {
            _currIndex = index;
          });
        },
      ),
    );
  }

  /// 初始化菜单栏
  _initContainer() {
    _listContent = new IndexedStack(
      children: <Widget>[IndexPage(), SystemPage(), MinePage()],
      index: _currIndex,
    );
//    _listContent.add(IndexPage());
//    _listContent.add(SystemPage());
//    _listContent.add(MinePage());
  }

  /// 初始化下面的button Menu
  List<BottomNavigationBarItem> _initBottom() {
    List<BottomNavigationBarItem> list = [];
    list.add(_initBottomNavigationBarItem(
        'images/huime_icon_shouye.png', 'images/me_icon_shouye.png', '首页'));
    list.add(_initBottomNavigationBarItem(
        'images/huime_icon_faxian.png', 'images/me_icon_faxian.png', '发现'));
    list.add(_initBottomNavigationBarItem(
        'images/huime_icon_wo.png', 'images/me_icon_wo.png', '我的'));
    return list;
  }

  /// 初始化单个的item
  BottomNavigationBarItem _initBottomNavigationBarItem(
      String defIcon, String activeIcon, String menuStr) {
    return BottomNavigationBarItem(
        activeIcon: Image.asset(
          activeIcon,
          width: ICON_WIDTH_ACTIVE,
          height: ICON_WIDTH_ACTIVE,
        ),
        icon: Image.asset(
          defIcon,
          width: ICON_WIDTH,
          height: ICON_WIDTH,
        ),
        title: Container(
          child: Text(menuStr),
          margin: const EdgeInsets.only(top: 4),
        ));
  }
}
