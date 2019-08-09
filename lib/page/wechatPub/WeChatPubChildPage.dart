import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/we_chat_pub_child_list_impl_entity.dart';
import 'package:flutter_app/common/dao/WeChatPubDao.dart';
import 'package:flutter_app/widget/LyWidget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';

/// 公众号列表 子类
class WeChatPubChildPage extends StatefulWidget {
  final int pubId;

  const WeChatPubChildPage({Key key, this.pubId}) : super(key: key);

  @override
  _WeChatPubChildPageState createState() => _WeChatPubChildPageState(pubId);
}

class _WeChatPubChildPageState extends State<WeChatPubChildPage>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  final int pubId;
  int _currIndex = 1;
  WeChatPubDao _weChatPubDao;
  List<WeChatPubChildListImplDataData> _listForPubList = [];

  _WeChatPubChildPageState(this.pubId);

  @override
  void initState() {
    _weChatPubDao = new WeChatPubDao();
    _loadPubList();
    super.initState();
  }

  _loadPubList() {
    _weChatPubDao.getWeChatChildList(_currIndex, pubId).then((value) {
      if (value.data != null) {
        setState(() {
          if (_currIndex == 1) {
            _listForPubList.clear();
          }
          _listForPubList.addAll(value.data.datas);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        EasyRefresh(
          key: _easyRefreshKey,
          behavior: ScrollOverBehavior(),
          refreshHeader: MaterialHeader(
            key: _headerKey,
          ),
          refreshFooter: ClassicsFooter(
            key: _footerKey,
            bgColor: Colors.transparent,
            textColor: Colors.black87,
            moreInfoColor: Colors.black54,
            showMore: true,
          ),
          onRefresh: () async {
            await new Future.delayed(const Duration(seconds: 1), () {
              _currIndex = 1;
              _loadPubList();
            });
          },
          loadMore: () async {
            await new Future.delayed(const Duration(seconds: 1), () {
              _currIndex++;
              _loadPubList();
            });
          },
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Text(_listForPubList[index].title);
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: _listForPubList.length),
        ),
        Offstage(
          child: LyWidget.loadingWidget(),
          offstage: _listForPubList.isNotEmpty,
        )
      ],
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
