import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/article_list_impl_entity.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/page/article/ArticleDetailPage.dart';

class ArticleWidget {
  /// 渲染item
  static Widget renderListViewItem(
      BuildContext context, ArticleListImplDataData data) {
    return InkWell(
      child: Container(
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
                maxLines: 2,
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
      ),
      onTap: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new ArticleDetailPage(data.title, data.link);
        }));
      },
    );
  }
}
