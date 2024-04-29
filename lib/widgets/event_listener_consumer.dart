import 'dart:async';

import 'package:event_bus/widgets/reactive_widget.dart';
import 'package:flutter/material.dart';

import 'package:event_bus/events/event_bus.dart';

class EventBusConsumer<T> extends StatefulWidget {
  final Widget child;
  final List<String> eventKeys;

  const EventBusConsumer({
    super.key,
    required this.child,
    required this.eventKeys,
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
      print("For the type of event: $eventType");
      return EventBus.getInstance().on(eventType).listen((event) {
        print("Event received: ${event.metaData.event}");
        (widget.child as ReactiveWidget).onEvent(
          event.metaData.event,
          event.metaData.data,
        );
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
