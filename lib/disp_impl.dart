import 'package:easy_events/base_event.dart';
import 'package:easy_events/dispatch.dart';
import 'package:easy_events/event_center.dart';
import 'package:easy_events/event_const.dart';

class DispImpl implements Dispatch {
  static int __uuid = 0;
  String _uuid = "";

  DispImpl(key) {
    ++__uuid;
    this._uuid = "${__uuid}.${key}";
  }

  void emit<T extends BaseEvent>(String key, T event) {
    EventCenter.emit(_uuid, key, event);
  }

  void on(String key, OnEvent handler, Priority priority) {
    EventCenter.on(_uuid, key, this, handler, priority);
  }

  void off(String key, OnEvent handler, Priority priority) {
    EventCenter.off(_uuid, key, this, handler, priority);
  }

  void doEvent(String key, Object param) {
    emit(key, new BaseEvent(key, param));
  }

  void clear() {
    EventCenter.clear(_uuid);
  }

  void init() {}

  void destroy() {
    stop();
    clear();
  }

  void start() {
    EventCenter.setPaused(_uuid, false);
  }

  void stop() {
    EventCenter.setPaused(_uuid, true);
  }

  String get uuid => _uuid;
}
