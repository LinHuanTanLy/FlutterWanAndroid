import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/system_tree_impl_entity.dart';
import 'package:flutter_app/common/dao/SystemDao.dart';
import 'package:flutter_app/conf/ColorConf.dart';
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
                              'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3026965303,2338464948&fm=26&gp=0.jpg',
                              fit: BoxFit.fitWidth,
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
    return GridView.builder(
        itemCount: data[_currIndex].children.length,
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1,
            maxCrossAxisExtent: 200),
        itemBuilder: (context, index) {
          return Container(
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
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
