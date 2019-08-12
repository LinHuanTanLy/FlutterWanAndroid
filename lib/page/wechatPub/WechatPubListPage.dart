import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/we_chat_pub_list_impl_entity.dart';
import 'package:flutter_app/common/dao/WeChatPubDao.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/widget/LyAppBar.dart';

import 'WeChatPubChildPage.dart';

/// 微信公众号列表
class WeChatPubListPage extends StatefulWidget {
  final int defPageIndex;

  WeChatPubListPage({this.defPageIndex});

  @override
  _WeChatPubListPageState createState() =>
      _WeChatPubListPageState(defPageIndex);
}

class _WeChatPubListPageState extends State<WeChatPubListPage>
    with TickerProviderStateMixin {
  WeChatPubDao _weChatPubDao;
  List<WeChatPubListImplData> _listForWeChatList = [];
  final int defPageIndex;
  TabController _tabController;

  _WeChatPubListPageState(this.defPageIndex);

  @override
  void initState() {
    _weChatPubDao = new WeChatPubDao();
    _weChatPubDao.getWeChatList((value){
      setState(() {
        _listForWeChatList.addAll(value.data);
        _tabController =
        new TabController(length: _listForWeChatList.length, vsync: this);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_tabController == null) {
      _tabController =
          new TabController(length: _listForWeChatList.length, vsync: this);
    }
    if (defPageIndex != null) {
      _tabController.animateTo(defPageIndex);
    }
    return Scaffold(
      appBar: LyAppBar.commAppBar('公众号列表',
          bottom: TabBar(
              isScrollable: true,
              unselectedLabelColor: ColorConf.colorF5F5F5,
              labelColor: ColorConf.colorFFFFFF,
              labelStyle: TextStyle(fontSize: 15),
              unselectedLabelStyle: TextStyle(fontSize: 15),
              controller: _tabController,
              tabs: _listForWeChatList
                  .map((e) => Tab(
                        text: e.name,
                      ))
                  .toList())),
      body: TabBarView(
        children: _listForWeChatList
            .map((e) => WeChatPubChildPage(
                  pubId: e.id,
                ))
            .toList(),
        controller: _tabController,
      ),
    );
  }
}
