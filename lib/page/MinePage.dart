import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/user_info_impl_entity.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/redux/AppState.dart';
import 'package:flutter_redux/flutter_redux.dart';

/// 个人中心
class MinePage extends StatefulWidget {



 final List<String> _listForTitle=['我的收藏','邀请好友','关于我'];
 final List<String> _listForIcon=['images/me_icon_shoucang.png','images/author_pic1.jpg','images/author_pic1.jpg'];
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
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 180,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('images/bg.png'),
                  fit: BoxFit.fitWidth,
                )),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                              'images/author_pic1.jpg',
                            )),
                            border: Border.all(
                                color: ColorConf.colorFFFFFF, width: 2)),
                        width: 90,
                        height: 90,
                        margin: const EdgeInsets.only(left: 20, right: 6)),
                    Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 60, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            userInfo != null && userInfo.data != null
                                ? userInfo.data.nickname
                                : '暂未登录',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: ColorConf.colorFFFFFF),
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                top: 4,
                              ),
                              child: Text(
                                '不积跬步无以至千里',
                                style: TextStyle(
                                    fontSize: 13, color: ColorConf.colorFFFFFF),
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.only(
                          top: 30, left: 30, bottom: 30, right: 10),
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.settings,
                        color: ColorConf.colorFFFFFF,
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                child: ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _renderListViewItem(widget._listForIcon[index],widget._listForTitle[index],(){});
                    },
                    separatorBuilder: (BuildContext context, index) {
                      return Divider(
                        height: 1,
                      );
                    },
                    itemCount: widget._listForTitle.length),
              )
            ],
          ),
        );
      },
    );
  }

  /// 渲染ListView Item
  Widget _renderListViewItem(iconStr, titleStr, callback) {
    return GestureDetector(
      child: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        child: Row(
          children: <Widget>[
            Image.asset(
              iconStr,
              width: 20,
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                titleStr,
                style: TextStyle(fontSize: 15, color: ColorConf.color48586D),
              ),
            )
          ],
        ),
      ),
      onTap: callback,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
