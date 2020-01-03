import 'package:flutter/services.dart';

import 'flutter_bridge_const.dart';

class EventChannelManager {
  EventChannel eventChannel;

  factory EventChannelManager() => _getInstance();

  static EventChannelManager get instance => _getInstance();
  static EventChannelManager _instance;

  EventChannelManager._internal() {
    eventChannel = EventChannel(FlutterBridgeConst.eventChannel);
  }

  static EventChannelManager _getInstance() {
    if (_instance == null) {
      _instance = new EventChannelManager._internal();
    }
    return _instance;
  }
}

class BasicMessageChannelManager {
  BasicMessageChannel basicMessageChannel;

  factory BasicMessageChannelManager() => _getInstance();

  static BasicMessageChannelManager get instance => _getInstance();
  static BasicMessageChannelManager _instance;

  BasicMessageChannelManager._internal() {
    basicMessageChannel = BasicMessageChannel<String>(
        FlutterBridgeConst.basicMessageChannel, StringCodec());
  }

  static BasicMessageChannelManager _getInstance() {
    if (_instance == null) {
      _instance = new BasicMessageChannelManager._internal();
    }
    return _instance;
  }
}

class MethodChannelManager {
  MethodChannel methodChannel;

  factory MethodChannelManager() => _getInstance();

  static MethodChannelManager get instance => _getInstance();
  static MethodChannelManager _instance;

  MethodChannelManager._internal() {
    methodChannel = MethodChannel(FlutterBridgeConst.methodChannel);
  }

  static MethodChannelManager _getInstance() {
    if (_instance == null) {
      _instance = new MethodChannelManager._internal();
    }
    return _instance;
  }
}

