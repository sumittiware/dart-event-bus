import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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

class ColourChanger with ChangeNotifier {
  Color _color = Colors.red;

  Color get color => _color;

  void changeColor(Color newColor) {
    _color = newColor;
    notifyListeners();
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  Color _bg = Colors.red;

  @override
  Widget build(BuildContext context) {
    return EventBusConsumer(
      eventKeys: const <String>['color_change'],
      onEvent: (event, EventData metaData) {
        if (event == 'color_change') {
          final Color newColor = metaData.data['color'];
          setState(() {
            _bg = newColor;
          });
        }
      },
      child: Scaffold(
        backgroundColor: _bg,
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return const SecondScreen();
          }));
        }),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Color'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => EventBus.getInstance().fire(
                EventData(
                  key: 'color_change',
                  data: {
                    'color': Colors.red,
                  },
                ),
              ),
              child: const SizedBox(
                height: 100,
                width: 100,
                child: ColoredBox(color: Colors.green),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () => EventBus.getInstance().fire(
                EventData(
                  key: 'color_change',
                  data: {
                    'color': Colors.blue,
                  },
                ),
              ),
              child: const SizedBox(
                height: 100,
                width: 100,
                child: ColoredBox(color: Colors.blue),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () => EventBus.getInstance().fire(
                EventData(
                  key: 'color_change',
                  data: {
                    'color': Colors.yellow,
                  },
                ),
              ),
              child: const SizedBox(
                height: 100,
                width: 100,
                child: ColoredBox(color: Colors.yellow),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
