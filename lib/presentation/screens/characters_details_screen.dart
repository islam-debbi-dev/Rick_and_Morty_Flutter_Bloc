import 'package:flutter/material.dart';
import 'package:flutter_with_bloc/constants/my_colors.dart';

import '../../data/models/characters.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final Character character;

  const CharactersDetailsScreen({super.key, required this.character});

  Widget biuldSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600, // height of the picteur
      pinned: true, // to make it always on top
      stretch: true, // to make it strech when scrolling
      backgroundColor: MyColors.darkgray,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true, // to make the title in the center
        title: Text(
          character.name,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: MyColors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.image,
            fit: BoxFit.cover, // to make it cover the whole space
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow
          .ellipsis, // to make pionts in the end if text is too long and i'm not interested in the rest of the text

      text: TextSpan(
        text: '$title: ',
        style: TextStyle(
          color: MyColors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.grey,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.grey,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      indent: endIndent,
      endIndent: endIndent / 2,
      color: MyColors.darkGrey,
      thickness: 2, // thickness of the line
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.darkgray,
      body: CustomScrollView(
        slivers: [
          biuldSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  characterInfo('Status', character.status),
                  buildDivider(100),
                  SizedBox(height: 10),
                  characterInfo('Species', character.species),
                  buildDivider(100),
                  if (character.type.isNotEmpty) ...[
                    SizedBox(height: 10),
                    characterInfo('Type', character.type),
                    buildDivider(100),
                  ],
                  SizedBox(height: 10),
                  characterInfo('Gender', character.gender),
                  buildDivider(100),
                  SizedBox(height: 10),
                  characterInfo('Origin', character.origin.name),
                  buildDivider(100),
                  SizedBox(height: 10),
                  characterInfo('Location', character.location.name),
                  buildDivider(100),
                  SizedBox(height: 10),
                  characterInfo('Episodes', character.episode.join(' / ')),
                  buildDivider(100),
                  SizedBox(height: 10),
                  characterInfo('Created', character.created),
                  buildDivider(100),
                  SizedBox(height: 300),
                ],
              ),
            )
          ])),
        ],
      ),
    );
  }
}
