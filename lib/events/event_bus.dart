// dart imports
import 'dart:async';

// flutter imports
import 'package:flutter/material.dart';

// local imports
import 'package:event_bus/models/events_metadata.dart';

/// Dispatches events to listeners using the Dart [Stream] API. The [EventBus]
/// enables decoupled applications. It allows objects to interact without
/// requiring to explicitly define listeners and keeping track of them.
///
/// Not all events should be broadcasted through the [EventBus] but only those of
/// general interest.
///
/// Events are normal Dart objects. By specifying a class, listeners can
/// filter events.
///
class EventBus {
  static EventBus? _instance;

  static EventBus getInstance({bool sync = false}) {
    _instance ??= EventBus._internal(sync: sync);
    return _instance!;
  }

  /// Creates an [EventBus].
  ///
  /// If [sync] is true, events are passed directly to the stream's listeners
  /// during a [fire] call. If false (the default), the event will be passed to
  /// the listeners at a later time, after the code creating the event has
  /// completed.
  @protected
  EventBus._internal({bool sync = false})
      : _streamController = StreamController.broadcast(
          sync: sync,
        );

  StreamController<Event> _streamController;

  /// Controller for the event bus stream.
  StreamController<Event> get streamController => _streamController;

  /// Listens for events of Type [T] and its subtypes.
  ///
  /// The method is called like this: myEventBus.on<MyType>();
  ///
  /// If the method is called without a type parameter, the [Stream] contains every
  /// event of this [EventBus].
  ///
  /// The returned [Stream] is a broadcast stream so multiple subscriptions are
  /// allowed.
  ///
  /// Each listener is handled independently, and if they pause, only the pausing
  /// listener is affected. A paused listener will buffer events internally until
  /// unpaused or canceled. So it's usually better to just cancel and later
  /// subscribe again (avoids memory leak).
  ///
  Stream<Event> on(String eventKey) {
    return streamController.stream
        .where((event) => event.key == eventKey)
        .cast<Event>();
  }

  /// Fires a new event on the event bus with the specified [event].
  ///
  void fire(Event event) {
    streamController.add(event);
  }

  /// Destroy this [EventBus]. This is generally only in a testing context.
  ///
  void destroy() {
    _streamController.close();
  }
}
