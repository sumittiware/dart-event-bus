import 'package:flutter/material.dart';

abstract class ReactiveWidget extends StatefulWidget {
  const ReactiveWidget({super.key});

  @override
  State<ReactiveWidget> createState();

  void onEvent(
    String event,
    Map<String, dynamic> data,
  );
}
