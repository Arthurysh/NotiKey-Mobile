import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoSwitchWidget extends StatefulWidget {
  final Function switchFunc;
  CupertinoSwitchWidget(this.switchFunc);
  @override
  _CupertinoSwitchWidgetState createState() => _CupertinoSwitchWidgetState();
}

class _CupertinoSwitchWidgetState extends State<CupertinoSwitchWidget> {
  var _lights = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoSwitch(
        value: _lights,
        onChanged: (bool value) {
          setState(() {
            _lights = value;
            widget.switchFunc();
          });
        },
      ),
    );
  }
}
