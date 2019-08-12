import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/user_info_impl_entity.dart';
import 'package:flutter_app/redux/AppState.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); //必须添加
    return StoreConnector<AppState, UserInfoImplEntity>(
      converter: (store) => store.state.userInfo,
      builder: (context, userInfo) {
        return Container(
          child: Text(json.encode(userInfo)),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
