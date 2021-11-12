import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itg_marvel_task/constants/colors.dart';
import 'package:itg_marvel_task/models/character_model.dart';
import 'package:itg_marvel_task/utils/dimens.dart';
import 'package:itg_marvel_task/widgets/text_widget.dart';

class CharacterNameDescriptionWidget extends StatelessWidget {
  final CharacterResult characterModel;
  final bool isName;
  const CharacterNameDescriptionWidget({Key? key, required this.characterModel, required this.isName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          color: kRedColor,
          sizeByPercent: k22TextSize,
          text: isName ?tr("name"):tr("description"),
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: setHeight(context, 0.01),
        ),
        TextWidget(
          color: kWhiteColor,
          sizeByPercent: k16TextSize,
          text: isName?characterModel.name!:characterModel.description!,
          fontWeight: FontWeight.bold,
          maxLines: 6,
        ),
        SizedBox(
          height: setHeight(context, 0.01),
        ),
      ],
    );
  }
}
