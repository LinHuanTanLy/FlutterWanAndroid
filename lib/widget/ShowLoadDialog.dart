import 'package:flutter/material.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// 加载菊花
class ShowLoadDialog extends StatefulWidget {
  final Function callback;

  const ShowLoadDialog({Key key, this.callback}) : super(key: key);

  static popDialog(BuildContext context){
    Navigator.of(context).pop();
  }
  @override
  _ShowLoadDialogState createState() => _ShowLoadDialogState(callback);
}

class _ShowLoadDialogState extends State<ShowLoadDialog> {
  final Function callBack;

  _ShowLoadDialogState(this.callBack);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConf.colorTrans,
      body: Center(
        child: Container(
          height: 140,
          width: 140,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorConf.colorCCFFFFFF),
          child: SpinKitWave(
            itemBuilder: (_, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: ColorConf.colorGreen,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
