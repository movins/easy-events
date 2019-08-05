class AutoBlock {
  final String key;
  final String module;
  const AutoBlock(this.module, this.key);
}

class AutoMethod {
  final String key;
  final String block;
  final String module;
  const AutoMethod(this.module, this.block, this.key);
}

class AutoHandler {
  final String block;
  final String module;
  const AutoHandler(this.module, this.block);
}

class AutoListener {
  final String key;
  const AutoListener(this.key);
}

abstract class IBase {
  static int __uuid = 0;
  String _uuid = "";

  IBase([String key = ""]) {
    _uuid = "${++__uuid}.${key}";
  }

  String get uuid => _uuid;

  void init();
  void dispose();
  void start();
  void stop();
}

abstract class IBlock implements IBase {
  dynamic excute(String method, [String param]);
  void on(String event, [int priority]);
  void off(String event, [int priority]);
}

abstract class IModule implements IBase {
  dynamic excute(String block, String method, [String param]);
  void on(String block, String event, [int priority]);
  void off(String block, String event, [int priority]);
}

abstract class IModel implements IBase {
  dynamic excute(String module, String block, String method, [String param]);
  void on(String module, String block, String event, [int priority]);
  void off(String module, String block, String event, [int priority]);
}

