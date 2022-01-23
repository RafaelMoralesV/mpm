import 'package:flutter/material.dart';
import 'package:mts/classes/mtg_card.dart';
import 'package:url_launcher/url_launcher.dart';

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
              return CardDetails(card: snapshot.data!);
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class CardDetails extends StatelessWidget {
  final MtgCard card;

  const CardDetails({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.network(
            card.imageUris!['normal'].toString(),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
          Text(
            card.name,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            child: const Text(
              "Ver en Scryfall",
              style: TextStyle(fontSize: 20),
            ),
            onTap: () => launch(card.uri),
          )
        ],
      ),
    );
  }
}
