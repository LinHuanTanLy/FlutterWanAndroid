import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/impl/project_list_child_impl_entity.dart';
import 'package:flutter_app/common/bean/impl/search_hot_impl_entity.dart';
import 'package:flutter_app/common/dao/SearchDao.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_app/utils/toast/ToastUtils.dart';
import 'package:flutter_app/widget/ProjectWidget.dart';

/// 搜索页面
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controllerForSearch = TextEditingController();
  SearchDao _searchDao = new SearchDao();

  List<SearchHotImplData> _hotSearchList = [];
  List<ProjectListChildImplDataData> _searchResult = [];
  int _currIndex = 0;

  @override
  void initState() {
    _searchDao.getSearchHot((SearchHotImplEntity value) {
      setState(() {
        _hotSearchList.addAll(value.data);
      });
    });

    super.initState();
  }

  /// 进行搜索
  doSearch(String keyWorld) {
    _searchDao.searchArticle(_currIndex, keyWorld,
        (List<ProjectListChildImplDataData> value) {
      setState(() {
        _searchResult.clear();
        _searchResult.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        titleSpacing: 0,
        backgroundColor: Colors.green,
        title: Container(
          decoration: BoxDecoration(
              color: ColorConf.colorFFFFFF,
              borderRadius: BorderRadius.circular(20)),
          child: TextField(
            decoration: InputDecoration(
                hintText: '搜索文章/标签',
                hintStyle:
                    TextStyle(fontSize: 13, color: ColorConf.color48586D),
                contentPadding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 10, right: 10),
                border: InputBorder.none),
            controller: _controllerForSearch,
            keyboardType: TextInputType.text,
            onEditingComplete: () {},
            onChanged: (String inputStr) {},
            textInputAction: TextInputAction.done,
          ),
        ),
        actions: <Widget>[
          InkWell(
            child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text('搜索'),
            ),
            onTap: () {
              String inputKeyWorld = _controllerForSearch.text;
              if (inputKeyWorld != null && inputKeyWorld.isNotEmpty) {
                _currIndex = 0;
                doSearch(inputKeyWorld);
              } else {
                ToastUtils.showTs('请输入搜索的关键词');
              }
            },
          )
        ],
      ),
      body: ListView.separated(
          primary: true,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == 0 && _searchResult.isEmpty) {
              return _renderHotSearch();
            } else {
              int realIndex = index;
              return ProjectWidget.renderListViewItem(
                  _searchResult[realIndex], () {});
            }
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: _searchResult.isEmpty ? 1 : _searchResult.length),
    );
  }

  /// 渲染热搜页面
  Widget _renderHotSearch() {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(12),
          child: Text(
            '大家都在搜',
            style: TextStyle(
                fontSize: 14,
                color: ColorConf.color000000,
                fontWeight: FontWeight.bold),
          ),
          alignment: Alignment.centerLeft,
        ),
        Container(
          margin: const EdgeInsets.only(left: 12, right: 12),
          child: GridView.builder(
            shrinkWrap: true,
            primary: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 2.5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            itemBuilder: (context, index) {
              SearchHotImplData item = _hotSearchList[index];
              return InkWell(
                child: Container(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: ColorConf.colorFFFFFF,
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: ColorConf.colorGreen, width: 1)),
                  child: Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 13, color: ColorConf.color48586D),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  _controllerForSearch.text = item.name;
                  _currIndex = 0;
                  doSearch(item.name);
                },
              );
            },
            itemCount: _hotSearchList.length,
          ),
        )
      ],
    );
  }
}
