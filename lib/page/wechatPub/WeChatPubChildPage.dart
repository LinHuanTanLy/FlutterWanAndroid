import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/we_chat_pub_child_list_impl_entity.dart';
import 'package:flutter_app/common/dao/WeChatPubDao.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/page/article/ArticleDetailPage.dart';
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
    _weChatPubDao.getWeChatChildList(_currIndex, pubId, (value) {
      setState(() {
        if (_currIndex == 1) {
          _listForPubList.clear();
        }
        _listForPubList.addAll(value.data.datas);
      });
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
                return _renderListItem(_listForPubList[index]);
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 4,
                );
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

  Widget _renderListItem(WeChatPubChildListImplDataData data) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              data.title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorConf.color000000),
            ),
            Container(
              margin: const EdgeInsets.only(top: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data.author,
                    style:
                        TextStyle(color: ColorConf.color929292, fontSize: 12),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Text(
                      data.niceDate,
                      style:
                          TextStyle(color: ColorConf.color929292, fontSize: 13),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new ArticleDetailPage(data.title, data.link);
        }));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
