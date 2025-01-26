import 'package:flutter_with_bloc/data/web_services/characters_api.dart';

import '../models/characters.dart';

class CharactersRepositoty {
  final CharactersApi charactersApi;

  CharactersRepositoty({required this.charactersApi});

  Future<List<Character>> getCharacters() async {
    final characters = await charactersApi.getCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }
}
