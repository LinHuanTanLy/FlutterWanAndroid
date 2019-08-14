import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/my_collection_article_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/project_list_child_impl_entity.dart';
import 'package:flutter_app/conf/ColorConf.dart';

class ProjectWidget {
  /// 渲染项目item
  static Widget renderListViewItem(
      ProjectListChildImplDataData projectListChildImplDataData, callBack) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Row(
                  children: <Widget>[
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('images/icon_author.png'),
                            fit: BoxFit.cover),
                        border: Border.all(
                            color: ColorConf.color929292, width: 0.5),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 6),
                      child: Text(
                        projectListChildImplDataData.author,
                        style: TextStyle(
                            fontSize: 14,
                            color: ColorConf.color000000,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
                Text(
                  '${projectListChildImplDataData.superChapterName}/${projectListChildImplDataData.chapterName}',
                  style: TextStyle(fontSize: 14, color: ColorConf.color929292),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            projectListChildImplDataData.title,
                            style: TextStyle(
                                fontSize: 16,
                                color: ColorConf.color000000,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            child: Text(
                              projectListChildImplDataData.desc,
                              style: TextStyle(
                                  fontSize: 14, color: ColorConf.color48586D),
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    flex: 4,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: Image.network(
                        projectListChildImplDataData.envelopePic,
                        fit: BoxFit.cover,
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    projectListChildImplDataData.niceDate,
                    style:
                        TextStyle(fontSize: 13, color: ColorConf.color929292),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: callBack,
    );
  }


  /// 渲染项目item
  static Widget renderListViewCollectionItem(
      MyCollectionArticleImplDataData projectListChildImplDataData, callBack) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('images/icon_author.png'),
                                fit: BoxFit.cover),
                            border: Border.all(
                                color: ColorConf.color929292, width: 0.5),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 6),
                          child: Text(
                            projectListChildImplDataData.author,
                            style: TextStyle(
                                fontSize: 14,
                                color: ColorConf.color000000,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
                Text(
                  '${projectListChildImplDataData.chapterName}',
                  style: TextStyle(fontSize: 14, color: ColorConf.color929292),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            projectListChildImplDataData.title,
                            style: TextStyle(
                                fontSize: 16,
                                color: ColorConf.color000000,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            child: Text(
                              projectListChildImplDataData.desc,
                              style: TextStyle(
                                  fontSize: 14, color: ColorConf.color48586D),
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    flex: 4,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: Image.network(
                        projectListChildImplDataData.envelopePic,
                        fit: BoxFit.cover,
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    projectListChildImplDataData.niceDate,
                    style:
                    TextStyle(fontSize: 13, color: ColorConf.color929292),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: callBack,
    );
  }
}
