import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/web_list_impl_entity.dart';
import 'package:flutter_app/common/dao/CollectionDao.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/widget/LyAppBar.dart';

/// 网址收藏列表
class CollectionWebSitePage extends StatefulWidget {
  @override
  _CollectionWebSitePageState createState() => _CollectionWebSitePageState();
}

class _CollectionWebSitePageState extends State<CollectionWebSitePage> {
  CollectionDao _collectionDao = new CollectionDao();

  List<WebListImplData> _listForWebListImplData = [];

  TextStyle _styleFotDialogTitle =
      TextStyle(fontSize: 16, color: ColorConf.color000000);

  @override
  void initState() {
    super.initState();
    _collectionDao.myWebSiteList((WebListImplEntity webListImplEntity) {
      setState(() {
        _listForWebListImplData.addAll(webListImplEntity.data);
      });
    });
  }

  /// 编辑网站
  _editWebSite(int index, int id, String name, String link) {
    TextEditingController _controllerForTitle =
        TextEditingController(text: name);
    TextEditingController _controllerForWeb = TextEditingController(text: link);
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Center(
              child: Text(
                '注意',
                style: _styleFotDialogTitle,
              ),
            ),
            contentPadding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 16.0),
            children: <Widget>[
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '标题',
                          style: TextStyle(
                              fontSize: 13, color: ColorConf.color929292),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: TextField(
                              controller: _controllerForTitle,
                              style: TextStyle(
                                  fontSize: 14, color: ColorConf.color48586D),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '网址',
                          style: TextStyle(
                              fontSize: 13, color: ColorConf.color929292),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: TextField(
                              controller: _controllerForWeb,
                              enabled: false,
                              style: TextStyle(
                                  fontSize: 14, color: ColorConf.color929292),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 200,
                      margin: const EdgeInsets.only(top: 20),
                      child: MaterialButton(
                        onPressed: () {
                          _collectionDao.editMyWebSite(
                              id, _controllerForTitle.text, link, () {
                            setState(() {
                              Navigator.of(context).pop(true);
                              _listForWebListImplData[index].name =
                                  _controllerForTitle.text;
                            });
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: ColorConf.colorGreen,
                        child: Text(
                          '确认修改',
                          style: TextStyle(
                              fontSize: 13, color: ColorConf.colorFFFFFF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  /// 删除收藏的网站
  _deleteWebSite(int index, int id) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              '注意',
              style: _styleFotDialogTitle,
            ),
            content: Text('您是否要从收藏列表中移除该网站?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    _collectionDao.deleteMyWebSite(id, () {
                      setState(() {
                        _listForWebListImplData.removeAt(index);
                      });
                    });
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    '确定',
                    style: TextStyle(fontSize: 14, color: ColorConf.colorGreen),
                  )),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('取消',
                      style: TextStyle(
                          fontSize: 14, color: ColorConf.color48586D)))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LyAppBar.commAppBar('网址收藏'),
      body: ListView.separated(
          itemBuilder: (context, index) {
            WebListImplData item = _listForWebListImplData[index];
            return Container(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 14, right: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.name,
                    style:
                        TextStyle(fontSize: 15, color: ColorConf.color000000),
                  ),
                  Divider(),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.edit,
                                size: 14,
                                color: ColorConf.color929292,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 6),
                                child: Text(
                                  '编辑',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: ColorConf.color929292),
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            _editWebSite(index, item.id, item.name, item.link);
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 50),
                          child: InkWell(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.delete_outline,
                                  size: 14,
                                  color: ColorConf.color929292,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 6),
                                  child: Text(
                                    '删除',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: ColorConf.color929292),
                                  ),
                                )
                              ],
                            ),
                            onTap: () {
                              _deleteWebSite(index, item.id);
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => Container(
                height: 8,
                color: ColorConf.colorF0F0F0,
              ),
          itemCount: _listForWebListImplData.length),
    );
  }
}
