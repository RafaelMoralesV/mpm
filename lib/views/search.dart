import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mts/classes/autocomplete_catalog.dart';
import 'package:mts/views/cards/show.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: TypeAheadField(
        textFieldConfiguration: const TextFieldConfiguration(
          autofocus: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        suggestionsCallback: (pattern) => fetchAutocompleteList(pattern),
        itemBuilder: (context, String cardName) =>
            ListTile(title: Text(cardName)),
        onSuggestionSelected: (String suggestion) async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowCard(
                cardName: suggestion,
              ),
            ),
          );
        },
      ),
    );
  }
}
