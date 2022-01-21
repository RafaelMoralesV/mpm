import 'dart:convert';

import 'package:http/http.dart';

class AutocompleteCatalog {
  List<String>? cards;

  AutocompleteCatalog({
    required this.cards,
  });

  factory AutocompleteCatalog.fromJson(Map<String, dynamic> json) {
    return AutocompleteCatalog(cards: json['data']);
  }
}

Future<List<String>> fetchAutocompleteList(String query) async {
  final uri =
      Uri.https('api.scryfall.com', '/cards/autocomplete', {'q': query});

  final response = await get(uri);

  if (response.statusCode == 200) {
    // Data is List<Dynamic>. We convert it to List<String> this way.
    return List<String>.from(jsonDecode(response.body)['data']);
  }

  throw Exception('Request to Scryfall API has failed');
}
