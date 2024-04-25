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
          eventKeys: const ["onColorChange"],
          child: ReactiveContainer(),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        int index = Random().nextInt(colors.length);
        print("Fireing the event");
        EventBus.getInstance().fire(EventData(
          data: {
            "color": colors[index],
          },
          key: 'onColorChange',
        ));
      }),
    );
  }
}
