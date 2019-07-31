import 'package:event_bus/base_event.dart';
import 'package:event_bus/event_const.dart';

abstract class Dispatch {
  void emit<T extends BaseEvent>(String key, T event);
  void on(String key, OnEvent handler, Priority priority);
  void off(String key, OnEvent handler, Priority priority);
}