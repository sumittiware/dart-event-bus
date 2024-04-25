import 'package:event_bus/event_types.dart';

class EventMetadata {
  final Event type;
  final Map<String, dynamic> metadata;

  EventMetadata({
    required this.type,
    required this.metadata,
  });
}
