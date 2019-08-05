import 'dart:async';

import 'package:easy_events/index.dart';

class BusImpl<T> extends IBase {
  StreamController _streamController;
  BusImpl(String key, {bool sync = false})
      : _streamController = StreamController.broadcast(sync: sync),
        super(key);

  Stream<BaseEvent> on(String key) {
    return _streamController.stream
        .where((event) => (event is BaseEvent) && (event.type == key))
        .cast<BaseEvent>();
  }

  void emit(String key, Object param) {
    final event = new BaseEvent(key, param);
    _streamController.add(event);
  }

  void init() {}

  void destroy() {
    _streamController.close();
  }

  void start() {}

  void stop() {}
}
