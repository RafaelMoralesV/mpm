import 'package:flutter/material.dart';
import 'package:mts/classes/mtg_card.dart';
import 'package:mts/components/basic_button.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BasicButton(
                link: card.uri,
                buttonText: 'SCG',
                iconPath: 'assets/icons/Scryfall.png',
                colors: const [Color(0xFF1D1C25), Color(0xFF431E3F)],
              ),
              BasicButton(
                  link:
                      "https://www.cardkingdom.com/catalog/search?filter[name]=${card.name}",
                  buttonText: 'CK',
                  iconPath: 'assets/icons/cardKingdom.png',
                  colors: const [Color(0xFF091F47), Color(0xFF091F47)]),
              BasicButton(
                link:
                    "https://starcitygames.com/search/?card_name=${card.name}",
                buttonText: 'SCG',
                iconPath: 'assets/icons/starcitygames.png',
                colors: const [Color(0xFF052B48), Color(0xFF005586)],
              ),
            ],
          )
        ],
      ),
    );
  }
}
