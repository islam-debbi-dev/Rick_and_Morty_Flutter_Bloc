import 'package:bloc/bloc.dart';
import 'package:flutter_with_bloc/data/repository/characters_repositoty.dart';
import 'package:meta/meta.dart';

import '../../data/models/characters.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepositoty charactersRepositoty;
  List<Character> characters = [];

  CharactersCubit(this.charactersRepositoty) : super(CharactersInitial());

  List<Character> getCharacters() {
    charactersRepositoty.getCharacters().then((characters) {
      emit(CharactersLoaded(characters: characters));
      this.characters = characters;
    });
    return characters;
  }
}
