import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/system_tree_impl_entity.dart';
import 'package:flutter_app/common/dao/SystemDao.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/page/system/SystemArticlePage.dart';
import 'package:flutter_app/widget/LyAppBar.dart';

class SystemPage extends StatefulWidget {
  @override
  _SystemPageState createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage>
    with AutomaticKeepAliveClientMixin {
  SystemDao _dao;
  List<SystemTreeImplData> data = [];
  int _currIndex = 0;
  double _width;
  double _widthForRightPart;

  List<String> _imgList = [
    'http://img4q.duitang.com/uploads/item/201505/03/20150503160745_ezjky.jpeg',
    'http://b-ssl.duitang.com/uploads/item/201811/04/20181104105054_uZC5C.jpeg',
    'http://b-ssl.duitang.com/uploads/item/201805/11/20180511135850_zdV2F.jpeg',
    'http://img5.mtime.cn/mg/2016/12/28/165359.26867102.jpg',
    'http://www.33lc.com/article/UploadPic/2012-8/2012838584578094.jpg',
    'http://www.33lc.com/article/UploadPic/2012-7/201272713562117180.jpg',
    'http://pic.3h3.com/up/2015-1/20151117170929097384.jpg',
    'http://image-258.258.com/258com/20170215/8b4e89f9cba2eff636e090404480158f.jpg',
    'http://pcs4.clubstatic.lenovo.com.cn/data/attachment/forum/201603/01/094015w3t3amt5k9nn8555.jpg',
    'http://b-ssl.duitang.com/uploads/item/201510/17/20151017182455_FRc38.jpeg',
    'http://www.33lc.com/article/UploadPic/2012-8/2012816100159067.jpg',
    'http://b-ssl.duitang.com/uploads/item/201509/26/20150926115124_fYZ4U.jpeg',
    'http://attach.bbs.miui.com/forum/201311/06/112611ogm0mq277h0awqex.jpg',
    'http://www.33lc.com/article/UploadPic/2012-7/201272615245017695.jpg',
    'http://attach.bbs.miui.com/forum/201304/25/195038zl3l55ok3gjkkfpt.jpg',
    'http://www.33lc.com/article/UploadPic/2012-8/20128314161610422.jpg',
    'http://attachments.gfan.com/forum/201504/02/2019125235gu0c5fdf5cd5.jpg',
    'http://b-ssl.duitang.com/uploads/item/201305/05/20130505032309_HJhAF.jpeg',
    'http://n1-q.mafengwo.net/s9/M00/B0/A4/wKgBs1asL6qAAkkiAAYbbwa4bx470.jpeg',
    'http://attachments.gfan.net.cn/forum/201504/14/075324wa4vmwz7m974ssea.jpg',
    'http://attachments.gfan.com/forum/201503/11/200815ttjkjb44poj4f7zo.jpg',
    'http://pic.rmb.bdstatic.com/68dd5a535c6a48ec0a1c7390d00420a8.jpeg',
    'http://b-ssl.duitang.com/uploads/item/201703/14/20170314202138_3FfXP.jpeg',
    'http://b-ssl.duitang.com/uploads/item/201510/17/20151017182423_VzY4R.jpeg',
    'http://b-ssl.duitang.com/uploads/item/201402/05/20140205182341_Lftct.jpeg',
    'http://www.33lc.com/article/UploadPic/2012-8/20128169575739515.jpg',
    'http://b-ssl.duitang.com/uploads/blog/201510/15/20151015210110_xQUCk.jpeg',
    'http://img5.duitang.com/uploads/item/201603/11/20160311104517_3c4ra.jpeg',
    'http://pic.rmb.bdstatic.com/520be6ba9595a59a7ef2437eb299f014.png',
    'http://b-ssl.duitang.com/uploads/item/201210/04/20121004225502_JBiB2.jpeg',
    'http://b3-q.mafengwo.net/s13/M00/D0/C7/wKgEaVyHgumAYv0FAAkKSlm_i7E96.jpeg',
    'http://attach.bbs.miui.com/forum/201209/21/124832q4nqamya3qammqd4.jpg',
    'http://b-ssl.duitang.com/uploads/item/201504/18/20150418H1827_zT2fV.jpeg',
    'http://b-ssl.duitang.com/uploads/item/201504/06/20150406H2911_szv82.jpeg',
    'http://b-ssl.duitang.com/uploads/blog/201510/15/20151015205845_KcfwN.jpeg',
    'http://b-ssl.duitang.com/uploads/item/201504/06/20150406H4917_Ejz4Z.jpeg',
    'http://www.rmzxb.com.cn/upload/resources/image/2016/03/12/211287.jpg',
    'http://www.33lc.com/article/UploadPic/2012-8/20128151142031994.jpg',
    'http://img5.duitang.com/uploads/item/201602/21/20160221161347_ZAK3k.jpeg',
    'http://b-ssl.duitang.com/uploads/blog/201510/15/20151015124658_Ga84F.jpeg',
    'http://b-ssl.duitang.com/uploads/item/201409/05/20140905223520_XxrGz.jpeg',
    'http://b-ssl.duitang.com/uploads/item/201410/24/20141024161607_niLhj.jpeg',
    'http://cdn.duitang.com/uploads/item/201306/20/20130620132857_aUsKv.jpeg',
    'http://pic.rmb.bdstatic.com/5d500535b92f9c980440f768361ea570.jpeg',
    'http://img3.duitang.com/uploads/item/201412/09/20141209001357_dzPVF.jpeg',
    'http://b-ssl.duitang.com/uploads/item/201604/20/20160420231356_rnRjQ.jpeg',
    'http://b-ssl.duitang.com/uploads/item/201310/30/20131030204715_xrEyh.jpeg',
    'http://b-ssl.duitang.com/uploads/item/201606/02/20160602085259_W34kd.jpeg',
    'http://b-ssl.duitang.com/uploads/blog/201309/14/20130914042258_2ntiK.jpeg',
    'http://www.33lc.com/article/UploadPic/2012-10/2012101811364439541.jpg',
    'http://www.33lc.com/article/UploadPic/2012-10/2012102214422825627.jpg',
    'http://www.33lc.com/article/UploadPic/2012-10/2012101516251932049.jpg',
    'http://b-ssl.duitang.com/uploads/item/201407/09/20140709174327_HEreN.jpeg'
  ];

  @override
  void initState() {
    _dao = new SystemDao();
    _dao.getSystemTree().then((value) {
      setState(() {
        data.addAll(value.data);
        debugPrint('the data is ${data.toString()}');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _widthForRightPart = _width * 0.75;
    super.build(context); //必须添加
    return Scaffold(
      appBar: LyAppBar.commAppBar('分类体系'),
      body: Row(
        children: <Widget>[
          Expanded(
            child: _leftPage(),
            flex: 1,
          ),
          VerticalDivider(
            width: 1,
          ),
          Expanded(
            child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      child: SliverAppBar(
                        bottom: PreferredSize(
                          preferredSize: Size(
                              _widthForRightPart, _widthForRightPart * 0.4),
                          child: Container(
                            child: Image.network(
                              _imgList[_currIndex],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        centerTitle: true,
                        titleSpacing: 0,
                        backgroundColor: ColorConf.colorFFFFFF,
                      ),
                    ),
                  ];
                },
                body: _rightPage()),
            flex: 3,
          ),
        ],
      ),
    );
  }

  /// 左边的布局
  Widget _leftPage() {
    return new Container(
      child: ListView.separated(
          itemBuilder: (context, index) {
            SystemTreeImplData _sysDao = data[index];
            return InkWell(
              child: Container(
                color: _currIndex == index
                    ? ColorConf.colorF2F2F2
                    : ColorConf.colorFFFFFF,
                padding: const EdgeInsets.only(top: 14, bottom: 14),
                child: Text(
                  _sysDao.name.toString(),
                  style: TextStyle(fontSize: 14, color: ColorConf.color48586D),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {
                setState(() {
                  _currIndex = index;
                });
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 1,
            );
          },
          itemCount: data.length),
    );
  }

  /// 右边的布局
  Widget _rightPage() {
    debugPrint('长度是${data.length}');
    debugPrint('爸爸的励志语长度是${_imgList.length}');
    return GridView.builder(
        itemCount: data.isNotEmpty ? data[_currIndex].children.length : 0,
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1,
            maxCrossAxisExtent: 200),
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: ColorConf.color929292, width: 0.5),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: <Widget>[
                  Image.network(
                      'https://www.wanandroid.com/resources/image/pc/logo.png'),
                  Container(
                    child: Text(
                      data[_currIndex].children[index].name,
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorConf.color48586D,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new SystemArticlePage(
                  cId: data[_currIndex].children[index].id.toString(),
                  title: data[_currIndex].children[index].name,
                );
              }));
            },
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
