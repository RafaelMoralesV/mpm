import 'package:flutter/material.dart';
import 'package:mts/classes/mtg_card.dart';

class ShowCard extends StatefulWidget {
  const ShowCard({Key? key, required this.cardName}) : super(key: key);

  final String cardName;

  @override
  State<ShowCard> createState() => _ShowCardState();
}

class _ShowCardState extends State<ShowCard> {
  late Future<MtgCard> futureCard;

  @override
  void initState() {
    super.initState();
    futureCard = fetchCardByName(widget.cardName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Show card!')),
      body: Center(
        child: FutureBuilder<MtgCard>(
          future: futureCard,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            if (snapshot.hasData) {
              return Image.network(
                snapshot.data!.imageUris!['small'].toString(),
              );
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
