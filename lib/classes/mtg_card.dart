import 'package:dio/dio.dart';
import 'package:mts/assets/constants.dart';

class MtgCard {
  final String id;
  final String name;
  final String uri;
  final int? edhrecRank;
  final Map<String, String>? imageUris;

  MtgCard({
    required this.id,
    required this.name,
    required this.uri,
    required this.edhrecRank,
    required this.imageUris,
  });

  factory MtgCard.from(Map<String, dynamic> object) {
    return MtgCard(
        id: object['id'],
        name: object['name'],
        uri: object['scryfall_uri'],
        edhrecRank: object['edhrec_rank'],
        imageUris: Map.from(object['image_uris']));
  }
}

Future<MtgCard> fetchRandomCard() async {
  var dio = Dio();

  final Response response = await dio.get('$api/cards/random');

  if (response.statusCode != 200) {
    throw Exception(
        'Request to Scryfall API has failed with Code: ${response.statusCode}');
  }

  return MtgCard.from(response.data);
}

Future<MtgCard> fetchCardByName(String name) async {
  final response =
      await Dio().get('$api/cards/named', queryParameters: {'exact': name});

  if (response.statusCode != 200) {
    throw Exception(
        'Request to Scryfall API has failed with Code: ${response.statusCode}');
  }

  return MtgCard.from(response.data);
}
