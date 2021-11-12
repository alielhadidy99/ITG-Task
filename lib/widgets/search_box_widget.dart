import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itg_marvel_task/constants/colors.dart';
import 'package:itg_marvel_task/providers/characters_provider.dart';
import 'package:itg_marvel_task/utils/dimens.dart';
import 'package:itg_marvel_task/widgets/text_form_field_widget.dart';
import 'package:itg_marvel_task/widgets/text_widget.dart';

class SearchBoxWidget extends StatelessWidget {
  final TextEditingController searchController;
  final CharactersProvider charactersProvider;

  const SearchBoxWidget(
      {Key? key,
      required this. searchController,
      required this.charactersProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Material(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: TextFormFieldWidget(
              charactersProvider: charactersProvider,
              controller: searchController,
              hintText: "Search...",
              icon: Icons.search,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(
                left: renderFontSizeFromPixels(context, kPadding8)),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: TextWidget(
                  text: tr("cancel"),
                  color: kRedColor,
                  sizeByPercent: k16TextSize,
                )),
          ),
        )
      ],
    );
  }
}
