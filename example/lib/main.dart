import 'dart:math';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const List<Color> colors = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EventBusConsumer(
          eventKeys: const ["color-change-key"],
          child: ReactiveContainer(),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        int index = Random().nextInt(colors.length);
        print("Firing  the event");
        EventBus.getInstance().fire(Event(
          metaData: EventMetaData(
            event: 'onColorChange',
            data: {
              "color": colors[index],
            },
          ),
          key: 'color-change-key',
        ));
      }),
    );
  }
}

class ReactiveContainer extends ReactiveWidget {
  ReactiveContainer({super.key});

  final state = _ReactiveContainerState();

  @override
  State<ReactiveContainer> createState() => state;

  @override
  void onEvent(String event, Map<String, dynamic> data) {
    state.onEvent(event, data);
  }
}

class _ReactiveContainerState extends State<ReactiveContainer>
    with AutomaticKeepAliveClientMixin {
  Color? color = Colors.red;

  void onEvent(String event, Map<String, dynamic> data) {
    print("Event received in state: $event");
    switch (event) {
      case "onColorChange":
        updateColor(data["color"] as Color);
        break;
    }
  }

  updateColor(Color newColor) {
    print("Changing the color");
    setState(() {
      color = newColor;
      print("New color: $color");
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print(color);
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }
}
