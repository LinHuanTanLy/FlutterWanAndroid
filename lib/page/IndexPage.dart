import 'package:flutter/material.dart';
import 'package:banner/banner.dart';
import 'package:flutter_app/common/bean/impl/article_list_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/banner_bean_impl_entity.dart';
import 'package:flutter_app/common/dao/ArticleDao.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/utils/comm/StringUtils.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  ArticleDao _articleDao;

  BannerBeanImplEntity _bannerBeanImplEntity;
  ArticleListImplEntity _articleTopImplEntity;

  @override
  void initState() {
    _articleDao = new ArticleDao();
    _articleDao.getBanner().then((value) {
      setState(() {
        _bannerBeanImplEntity = value;
      });
    });
    _articleDao.getArticleTop().then((value) {
      setState(() {
        debugPrint('the value is $value');
        _articleTopImplEntity = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _initAppBar(),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return index != 0
              ? Container(
                  height: 10,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  color: ColorConf.colorF0F0F0,
                )
              : Container(
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.whatshot,
                                color: Colors.green,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 4),
                                child: Text(
                                  '文章列表',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.green,
                                  ),
                                ),
                              )
                            ],
                          )),
                          Text(
                            '更多文章',
                            style: TextStyle(
                                fontSize: 13, color: ColorConf.color929292),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: ColorConf.color929292,
                          )
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                );
        },
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _renderBanner();
          } else {
            return _renderListViewItem(index - 1);
          }
        },
        itemCount: _articleTopImplEntity != null
            ? _articleTopImplEntity.data.datas.length + 1
            : 1,
      ),
    );
  }

  /// 渲染listView item
  Widget _renderListViewItem(int index) {
    var data = _articleTopImplEntity.data.datas[index];
    return Container(
      margin: const EdgeInsets.only(left: 14, right: 14, top: 4, bottom: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://www.wanandroid.com/resources/image/pc/logo.png'),
                              fit: BoxFit.cover),
                          border: Border.all(
                              color: ColorConf.color929292, width: 1),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        child: Text(
                          data.author,
                          style: TextStyle(
                              fontSize: 14, color: ColorConf.color929292),
                        ),
                      )
                    ],
                  )),
              Text(
                '${data.superChapterName}/${data.chapterName}',
                style: TextStyle(fontSize: 14, color: ColorConf.color929292),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              data.title,
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 15,
                  color: ColorConf.color000000,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 14),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'images/icon_like.png',
                  width: 16,
                  height: 16,
                  color: ColorConf.color929292,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 4),
                  child: Text(
                    '${data.zan}',
                    style:
                        TextStyle(fontSize: 14, color: ColorConf.color929292),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 渲染banner
  Widget _renderBanner() {
    return new Container(
      height: 180,
      child: new BannerView(
        data: _bannerBeanImplEntity != null ? _bannerBeanImplEntity.data : [],
        buildShowView: (index, data) {
          return Container(
            child: Image.network(
              data.imagePath,
              fit: BoxFit.fitWidth,
            ),
          );
        },
        onBannerClickListener: (index, data) {
          print(index);
        },
      ),
    );
  }

  AppBar _initAppBar() {
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: ColorConf.colorF2F2F2,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)),
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.search,
                    color: ColorConf.color929292,
                  ),
                  Text(
                    '搜索文章/标签',
                    style:
                        TextStyle(fontSize: 14, color: ColorConf.color929292),
                  )
                ],
              ),
            ),
          ),
          Container(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.settings,
                    size: 18,
                  ),
                  Text(
                    '标签',
                    style:
                        TextStyle(fontSize: 15, color: ColorConf.colorFFFFFF),
                  )
                ],
              ),
              margin: const EdgeInsets.only(left: 10))
        ],
      ),
    );
  }
}
