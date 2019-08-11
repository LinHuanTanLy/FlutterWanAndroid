import 'package:flutter/material.dart';
import 'package:flutter_app/conf/ColorConf.dart';

class LyAppBar {
  static AppBar commAppBar(String titleStr, {Widget bottom,}) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.green,
      centerTitle: true,
      bottom: bottom,
      title: Text(
        titleStr,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: ColorConf.colorFFFFFF,
        ),
      ),
    );
  }

  /// 首页 假的搜索框
  static AppBar searchAppBar({callBackForInput, callBackForRight}) {
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    color: ColorConf.colorF2F2F2,
                    border: Border.all(color: ColorConf.colorF2F2F2),
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
              onTap: callBackForInput,
            ),
          ),
          GestureDetector(
            child: Container(
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
                margin: const EdgeInsets.only(left: 10)),
            onTap: callBackForRight,
          )
        ],
      ),
    );
  }
}
