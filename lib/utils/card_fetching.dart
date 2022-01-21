import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mts/Classes/mtg_card.dart';

Future<MtgCard> fetchRandomCard() async {
  final response =
      await http.get(Uri.parse('https://api.scryfall.com/cards/random'));

  if (response.statusCode == 200) {
    return MtgCard.fromJson(jsonDecode(response.body));
  }

  throw Exception('Request to Scryfall API has failed');
}
