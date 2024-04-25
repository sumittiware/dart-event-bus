import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:event_bus/event_types.dart';
import 'package:event_bus/events_metadata.dart';
import 'package:flutter/material.dart';

class EventListenerWidget extends StatefulWidget {
  final Widget child;
  final List<Event> events;
  final Function(Event, EventMetadata) onEvent;

  const EventListenerWidget({
    super.key,
    required this.child,
    required this.events,
    required this.onEvent,
  });

  @override
  _EventListenerWidgetState createState() => _EventListenerWidgetState();
}

class _EventListenerWidgetState extends State<EventListenerWidget> {
  late List<StreamSubscription> _subscriptions;

  @override
  void initState() {
    super.initState();

    _subscriptions = widget.events.map((eventType) {
      return EventBus.getInstance().on(eventType).listen((event) {
        widget.onEvent(eventType, event);
      });
    }).toList();
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
