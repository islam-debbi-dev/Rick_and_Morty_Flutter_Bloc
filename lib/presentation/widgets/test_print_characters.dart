import 'package:flutter/material.dart';
import 'package:flutter_with_bloc/data/models/characters.dart';

import '../../constants/my_colors.dart';

class TestPrintCharacters extends StatelessWidget {
  const TestPrintCharacters({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    print(character.name);

    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridTile(
          footer: Container(
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
          child:
              Container(color: MyColors.grey, child: Text(character.status))),
    );
  }
}
