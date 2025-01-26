import 'package:flutter/material.dart';
import 'package:flutter_with_bloc/constants/my_colors.dart';

import '../../constants/string.dart';
import '../../data/models/characters.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({super.key, required this.character});

  final Character character;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, characterDetailsScreen,
              arguments: character);
        },
        child: GridTile(
            footer: Hero(
              tag: character.id,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: Colors.black54,
                alignment: Alignment.bottomCenter,
                child: Text(
                  character.name,
                  style: TextStyle(
                    color: MyColors.white,
                    fontSize: 16,
                    height: 1.3,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow
                      .ellipsis, // make pionts in the end if text is too long
                  maxLines: 2, // max lines to show
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            child: Container(
                color: MyColors.grey,
                child: character.image.isNotEmpty
                    ? FadeInImage(
                        width: double.infinity,
                        height: double.infinity,
                        placeholder:
                            AssetImage('assets/images/icon_loading.gif'),
                        image: NetworkImage(character.image),
                        fit: BoxFit.cover,
                      )
                    : Image.asset('assets/images/actor.png'))),
      ),
    );
  }
}
