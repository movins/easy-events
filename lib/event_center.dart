import 'package:easy_events/base_event.dart';
import 'package:easy_events/event_const.dart';

class EventBody {
  static final Map<int, OnEvent> _handers = new Map<dynamic, OnEvent>();
  static int __uuid = 0;
  Priority _priority;
  Object _listener;
  OnEvent _handler;
  int _key;

  EventBody(this._listener, this._handler, [ this._priority = Priority.NORMAL ]): _key = ++__uuid;

  void destroy() {
    _handers.remove(_key);
  }

  Priority get priority => _priority;

  bool same(Object listener, OnEvent handler, [Priority priority = Priority.NORMAL]) {
    return (_listener == listener) && (_handler == handler) && (_priority == priority);
  }

  bool has(Object listener) => _listener == listener;

  void onEvent(BaseEvent event) {
    _handler ?? _handler(event);
  }
}

class ModuleBody {
  bool _paused;
  Map<String, List<EventBody>> _events;

  ModuleBody([this._paused = false]): _events = new Map<String, List<EventBody>>();

  void _onEvents(List<EventBody> list, BaseEvent event) {
    list.forEach((EventBody body) => body?.onEvent(event));
  }

  int _indexOf(List<EventBody> list, Object listener, OnEvent handler, [Priority priority = Priority.NORMAL]) {
    return list.indexWhere((EventBody body) => body.same(listener, handler, priority));
  }

  void emit(String key, BaseEvent event) {
    if (_paused || !_events.containsKey(key)) {
      return;
    }
    List<EventBody> list = _events[key];
    list ?? _onEvents(List.from(list), event);
  }

  void add(String key, Object listener, OnEvent handler, [Priority priority = Priority.NORMAL]) {
    if (!_events.containsKey(key)) {
      _events[key] = new List<EventBody>();
    }
    List<EventBody> list = _events[key];
    if (_indexOf(list, listener, handler, priority) < 0) {
      list.add(new EventBody(listener, handler, priority));
      list.sort((EventBody b1, EventBody b2) => b2.priority.index - b1.priority.index);
    }
  }

  void remove(String key, Object listener, OnEvent handler, [Priority priority = Priority.NORMAL]) {
    List<EventBody> list = _events[key];
    if (list == null) {
      return;
    }
    int index = _indexOf(list, listener, handler, priority);
    if (index > -1) {
      EventBody body = list.removeAt(index);
      body ?? body.destroy();
    }
  }

  void clear(String key, Object listener) {
    List<EventBody> list = _events[key];
    list ?? list.removeWhere((EventBody body) => body.has(listener));
  }

  void clearAll() => _events.clear();

  void set paused(bool val) => _paused = val; 
}

class EventCenter {
  static Map<String, ModuleBody> _moduleMap = new Map<String, ModuleBody>();

  static void on(String key, String modKey, Object listener, OnEvent handler, [Priority priority = Priority.NORMAL]) {
    if(!_moduleMap.containsKey(key)) {
      _moduleMap[key] = new ModuleBody(!EventConst.switched);
    }
    ModuleBody module = _moduleMap[key];
    module ?? module.add(modKey, listener, handler, priority);

    EventConst.log("Listener add: key=$key, modKey=$modKey");
  }

  static void off(String key, String modKey, Object listener, OnEvent handler, [Priority priority = Priority.NORMAL]) {
    ModuleBody module = _moduleMap[key];
    module ?? module.remove(modKey, listener, handler, priority);

    EventConst.log("Listener remove: key=$key, modKey=$modKey");
  }

  static void emit(String key, String modKey, BaseEvent event) {
    if(!EventConst.switched || !_moduleMap.containsKey(key)) {
      return;
    }
    ModuleBody module = _moduleMap[key];
    module ?? module.emit(modKey, event);

    EventConst.log("Listener emit: key=$key, modKey=$modKey");
  }

  static void setPaused(String key, bool val) {
    ModuleBody module = _moduleMap[key];
    module?.paused = val;

    EventConst.log("Event pause: key=$key, enabled=$val");
  }

  static void clearAll() {
    _moduleMap.clear();
    EventConst.log("Event clearAll");
  }

  static void clear(String key) {
    ModuleBody module = _moduleMap[key];
    module ?? module.clearAll();
    EventConst.log("Event clear: key=$key");
  }
}