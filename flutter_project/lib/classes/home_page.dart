import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_project/classes/flutter_bridge_const.dart';
import 'package:flutter_project/classes/flutter_bridge_manager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  /// Properties
  final List<String> listTitleArray = [
    FlutterBridgeConst.openGalley,
    FlutterBridgeConst.takePhoto,
    FlutterBridgeConst.toNavigation,
    FlutterBridgeConst.removeData
  ];

  /// Method
  // 接收native传来的信息
  void _basicMessageMethod(BuildContext context) {
    BasicMessageChannelManager.instance.basicMessageChannel.setMessageHandler((message) async {
      Map map = json.decode(message);
      print('basicMessageMethod:' + '$map');
    });
  }

  // 发送信息给native
  void _clickAction(int index) {
    // 这个字典紧紧是为了举个例子
    Map<String, dynamic> map = {"name": listTitleArray[index], "arguments": "test"};

    MethodChannelManager.instance.methodChannel
        .invokeMethod(listTitleArray[index], map);
  }

  @override
  void initState() {
    super.initState();

    _basicMessageMethod(context);
  }

  @override
  Widget build(BuildContext context) {

    /// Widgets
    Widget itemWidget(String title) {
      return Column(
        children: <Widget>[
          Container(
            height: 50,
            alignment: AlignmentDirectional.center,
            child: Text(title),
          ),
          Divider(
            height: 1,
            color: Colors.grey[300],
          ),
        ],
      );
    }

    Widget listWidget = ListView.builder(
      shrinkWrap: true,
      itemCount: listTitleArray.length,
      physics: new NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            _clickAction(index);
          },
          behavior: HitTestBehavior.translucent,
          child: itemWidget(listTitleArray[index]),
        );
      },
    );

    return Scaffold(
      body: listWidget,
    );
  }
}
