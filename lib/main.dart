import 'package:flutter/material.dart';
import 'Classes/mtg_card.dart';
import 'utils/card_fetching.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<MtgCard> futureCard;

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
          child: FutureBuilder<MtgCard>(
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
