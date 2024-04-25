import 'dart:async';

import 'package:flutter/material.dart';

import 'package:event_bus/events/event_bus.dart';

class EventBusConsumer extends StatefulWidget {
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
        (widget.child as ReactiveWidget).onEvent(event.key, event.data);
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

abstract class ReactiveWidget {
  void onEvent(String event, Map<String, dynamic> data);
}

class ReactiveContainer extends StatefulWidget implements ReactiveWidget {
  _ReactiveContainerState? state;

  ReactiveContainer({super.key});

  @override
  State<ReactiveContainer> createState() {
    state = _ReactiveContainerState();
    return state!;
  }

  @override
  void onEvent(String event, Map<String, dynamic> data) {
    switch (event) {
      case "onColorChange":
        state!.updateColor(data["color"] as Color);
        break;
    }
  }
}

class _ReactiveContainerState extends State<ReactiveContainer> {
  Color? color = Colors.red;

  updateColor(Color newColor) {
    setState(() {
      color = newColor;
      print("New coloe");
    });
  }

  @override
  Widget build(BuildContext context) {
    print(color);
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }
}
