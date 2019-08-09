import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/we_chat_pub_list_impl_entity.dart';
import 'package:flutter_app/common/dao/WeChatPubDao.dart';
import 'package:flutter_app/conf/ColorConf.dart';

class IndexWeChatPubPart extends StatefulWidget {
  @override
  _IndexWeChatPubPartState createState() => _IndexWeChatPubPartState();
}

class _IndexWeChatPubPartState extends State<IndexWeChatPubPart>
    with AutomaticKeepAliveClientMixin {
  List<List<WeChatPubListImplData>> _weChatPubList = [];
  List<String> _authorPicList = [];
  WeChatPubDao _weChatPubDao;
  int _pageNum = 0;

  @override
  void initState() {
    _weChatPubDao = new WeChatPubDao();
    _weChatPubDao.getArticleTop().then((value) {
      setState(() {
        List<WeChatPubListImplData> _list = [];
        _list.addAll(value.data);
        _calculation(_list);
        _authorPicList.addAll(_weChatPubDao.getAuthorPicList());
      });
    });

    super.initState();
  }

  _calculation(List<WeChatPubListImplData> _list) {
    int remainder = _list.length % 8;
    _pageNum = _list.length ~/ 8;
    if (remainder > 0) {
      _pageNum++;
    }
    debugPrint('the value is $_list');
    debugPrint('the _pageNum is $_pageNum');
    for (int i = 0; i < _pageNum; i++) {
      if (i < _pageNum - 1) {
        List<WeChatPubListImplData> _temp = [];
        for (int j = 0; j < 8; j++) {
          _temp.add(_list[i * 8 + j]);
        }
        _weChatPubList.add(_temp);
      } else {
        List<WeChatPubListImplData> _temp = [];
        _temp.addAll(
          _list.sublist(i * 8, _list.length),
        );
        _weChatPubList.add(_temp);
      }
    }
    debugPrint('the _weChatPubList is $_weChatPubList');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _renderWeChatPublic();
  }

  /// 渲染微信公众号模块
  Widget _renderWeChatPublic() {
    return SizedBox.fromSize(
      size: Size.fromHeight(240),
      child: Card(
        elevation: 0.2,
        child: PageView.builder(
            itemCount: _pageNum,
            controller: PageController(viewportFraction: 1),
            itemBuilder: (context, index) {
              return _renderWeChatPubPage(index);
            }),
      ),
    );
  }

  Widget _renderWeChatPubPage(int currIndex) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
      child: GridView.builder(
        primary: false,
        shrinkWrap: false,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            childAspectRatio: 0.75),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(_authorPicList[currIndex * 8 + index]),
                      fit: BoxFit.cover),
                  border: Border.all(color: ColorConf.color929292, width: 0.5),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  _weChatPubList[currIndex][index].name,
                  style: TextStyle(fontSize: 12, color: ColorConf.color48586D),
                ),
              )
            ],
          );
        },
        itemCount: _weChatPubList[currIndex].length,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
