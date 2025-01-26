import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_with_bloc/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_with_bloc/presentation/screens/characters_Screen.dart';

import 'constants/string.dart';
import 'data/models/characters.dart';
import 'data/repository/characters_repositoty.dart';
import 'data/web_services/characters_api.dart';
import 'presentation/screens/characters_details_screen.dart';

class AppRouter {
  late CharactersRepositoty charactersRepositoty;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepositoty = CharactersRepositoty(charactersApi: CharactersApi());
    charactersCubit = CharactersCubit(charactersRepositoty);
  }
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: CharactersScreen(),
          ),
        );
      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => CharactersDetailsScreen(
                  character: character,
                ));
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
