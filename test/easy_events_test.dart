import 'package:easy_events/easy_events.dart';
import 'package:test/test.dart';

class TestEvent extends BaseEvent {
  TestEvent(type, [ eventData = null ]): super(type, eventData);
  static String INFO_CHANGED = "TestEvent.INFO_CHANGED";
}

class TestModule extends DispImpl {

  TestModule(): super('TestModule');
}

main() {
  group('[easyevents]', () {
    test('Fire one event', () {

    });
  });
}
