enum EventType {
  onClick,
  onLongPressed,
  onHover,
}

class EventData {
  final String key;
  final dynamic data;

  EventData({
    required this.key,
    required this.data,
  });
}

class EventMetaData {
  final EventType type;
  final Map<String, dynamic> metadata;

  EventMetaData({
    required this.type,
    required this.metadata,
  });
}
