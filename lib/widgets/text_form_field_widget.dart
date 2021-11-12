import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itg_marvel_task/constants/colors.dart';
import 'package:itg_marvel_task/providers/characters_provider.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final CharactersProvider charactersProvider;
  final Color cursorColor;
  final String hintText;
  final Color hintColor;
  final Color iconColor;
  final double borderRadius;
  final IconData icon;
  final InputBorder borderType;

  const TextFormFieldWidget(
      {Key? key,
      required this.controller,
      required this.charactersProvider,
      this.cursorColor = kRedColor,
      required this.hintText,
      this.hintColor = kGreyColor,
      this.iconColor = kGreyColor,
      this.borderRadius = 10,
      required this.icon,
      this.borderType = InputBorder.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (String value) {
        charactersProvider.charactersSearchList = [];
        charactersProvider.getCharacter(limit: 100,
            characterName: controller.text);
      },
      cursorColor: cursorColor,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: hintColor),
        prefixIcon: Material(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
        border: borderType,
        // errorStyle: TextStyle(color: primaryColor100),
      ),
    );
  }
}
