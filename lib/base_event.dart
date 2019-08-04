import 'package:easy_events/json_data.dart';

class BaseEvent {
  String type;
  JsonData eventData;

  BaseEvent(this.type, [ this.eventData = null ]);
}