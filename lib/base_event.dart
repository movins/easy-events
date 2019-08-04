class BaseEvent {
  String type;
  Object eventData;

  BaseEvent(this.type, [this.eventData = null]);
}
