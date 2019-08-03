import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);//必须添加
    return Container(child: Text('minePage'),);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
