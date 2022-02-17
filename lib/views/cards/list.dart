import 'package:flutter/material.dart';
import 'package:mpmagic/classes/mtg_card.dart';

class ListCards extends StatefulWidget {
  const ListCards({Key? key, required this.cardName}) : super(key: key);

  final String cardName;

  @override
  State<ListCards> createState() => _ListCardsState();
}

class _ListCardsState extends State<ListCards> {
  late Future<List<MtgCard>> futureCardList;

  @override
  void initState() {
    super.initState();
    futureCardList = queryCards(widget.cardName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Cartas')),
      body: Center(
        child: FutureBuilder<List<MtgCard>>(
          future: futureCardList,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            if (snapshot.hasData) {
              return CardList(cards: snapshot.data!);
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class CardList extends StatelessWidget {
  const CardList({Key? key, required this.cards}) : super(key: key);

  final List<MtgCard> cards;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final card = cards[index];

            return CardListItem(card: card);
          }),
    );
  }
}

class CardListItem extends StatelessWidget {
  const CardListItem({Key? key, required this.card}) : super(key: key);

  final MtgCard card;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.network(
            card.imageUris!['small'].toString(),
            height: 200,
          ),
          Flexible(
            child: Text(
              card.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
