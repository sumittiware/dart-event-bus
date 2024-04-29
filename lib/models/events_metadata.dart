/// EventData class is used to store the key and data of the event.
/// [key] will be used to uniquely identify the event. and and its consumer.
/// [data] will be used to pass the data to the consumer.
class Event {
  final String key;
  final EventMetaData metaData;

  Event({
    required this.key,
    required this.metaData,
  });
}

class EventMetaData {
  final String event;
  final Map<String, dynamic> data;

  EventMetaData({
    required this.event,
    required this.data,
  });
}
