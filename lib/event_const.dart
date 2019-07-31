import 'package:easy_events/base_event.dart';

enum Priority {
  LOW, // 低
  NORMAL, // 中
  HIGH // 高
}
typedef void OnEvent(BaseEvent event);

typedef void OnLogPrint(String content);

class EventConst {
  static OnLogPrint _onLog = null;
  static bool _debug = false;
  static bool _switched = true;

  static clear() {}

  static bool get switched => _switched;
  static void set switched(bool val) => _switched = val;

  static void log(String content){
    _onLog ?? _onLog(content);
  }

  static bool get debug => _debug;
  static void set debug(bool val) => _debug = val;

  static void set onLog(OnLogPrint val) => _onLog = val;
}