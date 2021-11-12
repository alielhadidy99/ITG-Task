import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itg_marvel_task/models/character_model.dart';

import 'character_name_desc_widget.dart';

class CharacterDetailsTop extends StatelessWidget {
  final CharacterResult characterResult;

  const CharacterDetailsTop({Key? key, required this.characterResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        characterResult.name == "" || characterResult.name == null
            ? const SizedBox()
            : CharacterNameDescriptionWidget(
                characterModel: characterResult,
                isName: true,
              ),
        characterResult.description == "" || characterResult.description == null
            ? const SizedBox()
            : CharacterNameDescriptionWidget(
                characterModel: characterResult,
                isName: false,
              ),
      ],
    );
  }
}
