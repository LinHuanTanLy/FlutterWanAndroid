import 'package:flutter/material.dart';
import 'package:flutter_app/conf/ColorConf.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// 加载菊花
class ShowLoadDialog extends StatefulWidget {
  final Function dismissDialog;

  const ShowLoadDialog({Key key, this.dismissDialog}) : super(key: key);

  static popDialog(BuildContext context, {voidCallback}) {
    new Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pop();
      if (voidCallback != null) {
        voidCallback();
      }
    });
  }

  @override
  _ShowLoadDialogState createState() => _ShowLoadDialogState(dismissDialog);
}

class _ShowLoadDialogState extends State<ShowLoadDialog> {
  final Function dismissDialog;

  _ShowLoadDialogState(this.dismissDialog);

  _dismissDialog() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    if (widget.dismissDialog != null) {
      widget.dismissDialog(() {
        Navigator.of(context).pop();
      });
    }
  }

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
