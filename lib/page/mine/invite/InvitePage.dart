import 'package:flutter/material.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/widget/LyAppBar.dart';

/// 邀请页面
class InvitePage extends StatefulWidget {
  @override
  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  double _height;
  double _width;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                Container(
                  height: _height * 0.75,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/person_invite_bg.png'),
                          fit: BoxFit.fill)),
                ),
                Column(
                  children: <Widget>[
                    LyAppBar.commAppBar('邀请送积分', color: Colors.transparent),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              "邀请好友",
                              style: TextStyle(
                                  fontSize: 46, color: ColorConf.colorFFFFFF),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "各得",
                                  style: TextStyle(
                                      fontSize: 46,
                                      color: ColorConf.colorFFFFFF),
                                ),
                                Text(
                                  "壕礼",
                                  style: TextStyle(
                                      fontSize: 46,
                                      color: ColorConf.colorCCFDF800),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          child: Image.asset(
                            'images/invite_star.png',
                            width: 20,
                          ),
                        )
                      ],
                    ),
                    Text(
                      '邀请好友加入，给TA赠送100积分，\n好友成功登录，你也可以获取100积分',
                      style:
                          TextStyle(fontSize: 12, color: ColorConf.colorFFFFFF),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '专属邀请码：凌宇是帅逼',
                            style: TextStyle(
                                fontSize: 16, color: ColorConf.colorFFFFFF),
                          ),
                          InkWell(
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 2, bottom: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                      Border.all(color: ColorConf.colorFFFFFF)),
                              child: Text(
                                '复制',
                                style: TextStyle(
                                    fontSize: 12, color: ColorConf.colorFFFFFF),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 4),
                      child: Image.asset(
                        'images/my_qr.png',
                        width: _width * 2 / 5,
                      ),
                    ),
                    Text(
                      '邀请好友扫码进行登录',
                      style:
                          TextStyle(fontSize: 12, color: ColorConf.colorFFFFFF),
                    ),
                  ],
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: _height * 0.72, left: 10, right: 10),
                  height: 90,
                  alignment: Alignment.center,
                  child: Card(
                    elevation: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _renderInviteInfoTitle(
                                  'images/invite_renshu_icon.png', '成功邀请（人）'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                      child: Text(
                                    '10',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 35,
                                        color: ColorConf.color48586D),
                                  )),
                                  Image.asset(
                                    'images/right_arrow.png',
                                    height: 20,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        VerticalDivider(),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _renderInviteInfoTitle(
                                'images/invite_reward_icon.png', '奖励积分（分）'),
                            Text(
                              '1000',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 35, color: ColorConf.color48586D),
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 50),
              height: 60,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/invite_btn_yaoqing.png'))),
            )
          ],
        ),
      ),
    );
  }

  /// 渲染邀请信息的title
  Row _renderInviteInfoTitle(String iconStr, String info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          iconStr,
          width: 12,
        ),
        Container(
          margin: const EdgeInsets.only(left: 2),
          child: Text(
            info,
            style: TextStyle(fontSize: 13, color: ColorConf.color48586D),
          ),
        ),
      ],
    );
  }
}
