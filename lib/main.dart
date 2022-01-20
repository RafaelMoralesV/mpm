import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Card {
  final String name;

  Card({
    required this.name,
  });

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      name: json['name'],
    );
  }
}

Future<Card> fetchRandomCard() async {
  final response =
      await http.get(Uri.parse('https://api.scryfall.com/cards/random'));

  if (response.statusCode == 200) {
    return Card.fromJson(jsonDecode(response.body));
  }

  throw Exception('Request to Scryfall API has failed');
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Card> futureCard;

  @override
  void initState() {
    super.initState();
    futureCard = fetchRandomCard();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch data Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Card>(
              future: futureCard,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                if (snapshot.hasData) {
                  return Text(snapshot.data!.name);
                }

                return const CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
