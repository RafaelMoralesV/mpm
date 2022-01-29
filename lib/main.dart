import 'package:flutter/material.dart';
import 'package:mts/views/search.dart';
import 'package:mts/views/testing.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch data Example',
      home: Testing(),
    );
  }
}
