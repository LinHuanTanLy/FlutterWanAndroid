import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/blog_list_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/system_tree_impl_entity.dart';
import 'package:flutter_app/common/dao/SystemDao.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/page/system/SystemArticlePage.dart';
import 'package:flutter_app/widget/LyAppBar.dart';

import 'article/ArticleDetailPage.dart';

///  体系页面
class SystemPage extends StatefulWidget {
  @override
  _SystemPageState createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage>
    with AutomaticKeepAliveClientMixin {
  SystemDao _dao;
  List<SystemTreeImplData> _listForSystemList = [];
  List<BlogListImplData> _listForBlog = [];
  int _currIndex = 0;
  List<Color> _colorList = [
    Color(0XFFFFB6C1),
    Color(0XFFFFF0F5),
    Color(0XFFFF1493),
    Color(0XFFDA70D6),
    Color(0XFFD8BFD8),
    Color(0XFFEE82EE),
    Color(0XFF8A2BE2),
    Color(0XFF9370DB),
    Color(0XFFE6E6FA),
    Color(0XFF4169E1),
    Color(0XFF6495ED),
    Color(0XFFB0C4DE),
    Color(0XFF1E90FF),
    Color(0XFF87CEFA),
    Color(0XFF00BFFF),
    Color(0XFF5F9EA0),
    Color(0XFF5F9EA0),
    Color(0XFF00CED1),
    Color(0XFF40E0D0),
    Color(0XFF7FFFAA),
    Color(0XFF3CB371),
    Color(0XFF8FBC8F),
    Color(0XFFF5F5DC),
    Color(0XFFEEE8AA),
    Color(0XFFDAA520),
    Color(0XFFFFE4B5),
    Color(0XFFFFE4C4),
    Color(0XFFFF4500),
    Color(0XFFCD5C5C),
    Color(0XFFFF6347),
  ];

  @override
  void initState() {
    _dao = new SystemDao();
    _dao.getSystemTree((value) {
      setState(() {
        _listForSystemList.addAll(value.data);
      });
    });

    _dao.getBlogList((value) {
      setState(() {
        _listForBlog.addAll(value.data);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            child: _rightPage(),
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
            if (index == 0) {
              return _renderLeftItem(0, '常用网站');
            } else {
              SystemTreeImplData _sysDao = _listForSystemList[index - 1];
              return _renderLeftItem(index, _sysDao.name.toString());
            }
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 1,
            );
          },
          itemCount: _listForSystemList.length + 1),
    );
  }

  /// 渲染左侧布局的item
  Widget _renderLeftItem(index, name) {
    return Container(
      color:
          _currIndex == index ? ColorConf.colorF2F2F2 : ColorConf.colorFFFFFF,
      child: InkWell(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 14, bottom: 14),
              child: Text(
                name,
                style: TextStyle(fontSize: 14, color: ColorConf.color48586D),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 3,
              color: _currIndex == index ? Colors.green : ColorConf.colorFFFFFF,
            )
          ],
        ),
        onTap: () {
          if (_currIndex == index) return;
          setState(() {
            _currIndex = index;
          });
        },
      ),
    );
  }

  /// 右边的布局
  Widget _rightPage() {
    return GridView.builder(
        itemCount: _currIndex == 0
            ? _listForBlog.length
            : _listForSystemList.isNotEmpty
                ? _listForSystemList[_currIndex-1].children.length
                : 0,
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 3,
            maxCrossAxisExtent: 150),
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: _colorList[Random().nextInt(_colorList.length)],
                  border: Border.all(color: ColorConf.color929292, width: 0.5),
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                child: Text(
                  _currIndex == 0
                      ? _listForBlog[index].name
                      : _listForSystemList[_currIndex-1].children[index].name,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConf.colorFFFFFF,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                if (_currIndex != 0) {
                  return new SystemArticlePage(
                    cId: _listForSystemList[_currIndex-1]
                        .children[index]
                        .id
                        .toString(),
                    title: _listForSystemList[_currIndex-1].children[index].name,
                  );
                } else {
                  return new ArticleDetailPage(
                    _listForBlog[index].name,
                    _listForBlog[index].link,
                  );
                }
              }));
            },
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
