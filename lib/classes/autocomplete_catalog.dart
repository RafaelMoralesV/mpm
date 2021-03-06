import 'package:dio/dio.dart';
import 'package:mpmagic/assets/constants.dart';

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
  if (query.isEmpty || query.length < 3) {
    return Future.value([]);
  }

  final response = await Dio().get('$api/cards/autocomplete', queryParameters: {
    'q': query,
    'include_extras': true,
  });

  if (response.statusCode == 200) {
    // Data is List<Dynamic>. We convert it to List<String> this way.
    return List<String>.from(response.data['data'].take(5));
  }

  throw Exception('Request to Scryfall API has failed');
}
