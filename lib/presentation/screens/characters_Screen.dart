import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_with_bloc/constants/my_colors.dart';

import '../../business_logic/cubit/characters_cubit.dart';
import '../../data/models/characters.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allcharacters;
  late List<Character> searchedcharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget buildSearchBar() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.darkGrey,
      style: TextStyle(color: MyColors.darkGrey),
      decoration: InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.darkgray, fontSize: 18),
      ),
      onChanged: (searchedText) {
        addSeatchedCharactersToList(searchedText);
      },
    );
  }

  void addSeatchedCharactersToList(String searchedText) {
    searchedcharacters = allcharacters
        .where((character) => character.name
            .toLowerCase() // to make it case insensitive
            .startsWith(
                searchedText.toLowerCase())) // to make it case insensitive
        .toList(); // to list to make it a list
    setState(() {}); // to rebuild the widget
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              setState(() {
                clearSearch();
                Navigator.pop(context);
              });
            },
            icon: Icon(Icons.clear_sharp)),
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearching,
          icon: Icon(Icons.search, color: MyColors.darkGrey),
        )
      ];
    }
  }

  void startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void stopSearching() {
    clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getCharacters();
  }

  Widget buildblocwidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allcharacters = state.characters;
          return buildLoadedListWidgets(allcharacters);
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Image.asset('assets/images/icon_loading.gif'),
      ),
    );
  }

  Widget buildLoadedListWidgets(List<Character> characters) {
    return SingleChildScrollView(
        child: Container(
      color: MyColors.darkgray,
      child: Column(
        children: [
          BuildeCharacterList(),
        ],
      ),
    ));
  }

  // build character list
  Widget BuildeCharacterList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchTextController.text.isNotEmpty
            ? searchedcharacters.length
            : allcharacters.length,
        itemBuilder: (context, index) {
          return CharacterItem(
            character: _searchTextController.text.isEmpty
                ? allcharacters[index]
                : searchedcharacters[index],
          );
        });
  }

  Widget buildAppBarTitle() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        'Characters',
        style: TextStyle(color: MyColors.darkGrey),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/wifi_GIF.gif'),
          Text(
            'No Internet Connection',
            style: TextStyle(
              color: MyColors.grey,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.darkgray,
        leading: _isSearching ? Container() : null,
        title: _isSearching ? buildSearchBar() : buildAppBarTitle(),
        actions: [
          ..._buildAppBarActions(),
        ],
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          List<ConnectivityResult> connectivity,
          Widget child,
        ) {
          final bool connected =
              !connectivity.contains(ConnectivityResult.none);
          if (connected) {
            return buildblocwidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: Center(
          child: showLoadingIndicator(),
        ),
      ),
      backgroundColor: MyColors.darkgray,
    );
  }
}
