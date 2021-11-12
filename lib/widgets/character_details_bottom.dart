import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itg_marvel_task/constants/colors.dart';
import 'package:itg_marvel_task/constants/constants.dart';
import 'package:itg_marvel_task/models/character_model.dart';
import 'package:itg_marvel_task/screens/web_view_screen.dart';
import 'package:itg_marvel_task/utils/dimens.dart';
import 'package:itg_marvel_task/utils/navigations.dart';
import 'package:itg_marvel_task/widgets/text_widget.dart';
class CharacterDetailsBottom extends StatelessWidget {
  final CharacterResult characterResult;
  const CharacterDetailsBottom({Key? key, required this.characterResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: tr("related_links"),
          maxLines: 1,
          color: kRedColor,
          sizeByPercent: 0.06,
        ),
        SizedBox(
          height: setHeight(context, 0.02),
        ),
        Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children:
          characterResult.urls!.map((e) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    navigateTo(
                        context,
                        const WebViewScreen(
                            kMarvelUrl));
                  },
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      TextWidget(
                          color: kWhiteColor,
                          sizeByPercent: 0.05,
                          text: e.type!),
                      const Icon(
                          Icons.arrow_forward_ios,
                          color: kWhiteColor
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: setHeight(context,0.02),
                )
              ],
            );
          }).toList(),
        ),
        SizedBox(
          height: setHeight(context, 0.1),
        ),
      ],
    );
  }
}
