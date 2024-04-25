import 'dart:async';

import 'package:flutter/material.dart';

import 'package:event_bus/events/event_bus.dart';
import 'package:event_bus/models/events_metadata.dart';

class EventBusConsumer extends StatefulWidget {
  final Widget child;
  final List<String> eventKeys;

  final Function(String, EventData) onEvent;

  const EventBusConsumer({
    super.key,
    required this.child,
    required this.eventKeys,
    required this.onEvent,
  });

  @override
  _EventBusConsumerState createState() => _EventBusConsumerState();
}

class _EventBusConsumerState extends State<EventBusConsumer> {
  late List<StreamSubscription> _subscriptions;

  @override
  void initState() {
    super.initState();

    _subscriptions = widget.eventKeys.map((eventType) {
      return EventBus.getInstance().on(eventType).listen((event) {
        widget.onEvent(event.data.type, event);
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
