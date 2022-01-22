import 'package:flutter/material.dart';
import 'package:mts/Classes/autocomplete_catalog.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mts/Classes/mtg_card.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch data Example',
      home: Scaffold(
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
          suggestionsCallback: (pattern) {
            return fetchAutocompleteList(pattern);
          },
          itemBuilder: (context, String cardName) {
            return ListTile(title: Text(cardName));
          },
          onSuggestionSelected: (String suggestion) async {
            print((await fetchCardByName(suggestion)).imageUris?['normal']);
          },
        ),
      ),
    );
  }
}
