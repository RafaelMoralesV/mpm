import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mpmagic/classes/autocomplete_catalog.dart';
import 'package:mpmagic/classes/mtg_card.dart';
import 'package:mpmagic/views/cards/list.dart';
import 'package:mpmagic/views/cards/show.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      child: SearchBar(),
    );
  }
}

class SearchBar extends StatelessWidget {
  SearchBar({
    Key? key,
  }) : super(key: key);

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _controller,
              autofocus: false,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: _controller.clear,
                  icon: const Icon(Icons.clear),
                  splashColor: Colors.transparent,
                ),
                hintText: '¿Qué carta buscas?',
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
        ),
        ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListCards(
                cardName: _controller.text,
              ),
            ),
          ),
          child: const Text("Go"),
        ),
      ],
    );
  }
}
