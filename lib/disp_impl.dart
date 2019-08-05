import 'package:easy_events/annotation.dart';
import 'package:easy_events/base_event.dart';
import 'package:easy_events/dispatch.dart';
import 'package:easy_events/event_center.dart';
import 'package:easy_events/event_const.dart';

class DispImpl extends IBase implements Dispatch {
  DispImpl(String key): super(key);

  void emit<T extends BaseEvent>(String key, T event) {
    EventCenter.emit(uuid, key, event);
  }

  void on(String key, OnEvent handler, Priority priority) {
    EventCenter.on(uuid, key, this, handler, priority);
  }

  void off(String key, OnEvent handler, Priority priority) {
    EventCenter.off(uuid, key, this, handler, priority);
  }

  void event(String key, Object param) {
    emit(key, new BaseEvent(key, param));
  }

  void clear() {
    EventCenter.clear(uuid);
  }

  void init() {}

  void dispose() {
    stop();
    clear();
  }

  void start() {
    EventCenter.setPaused(uuid, false);
  }

  void stop() {
    EventCenter.setPaused(uuid, true);
  }
}
