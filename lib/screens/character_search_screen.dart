import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itg_marvel_task/constants/colors.dart';
import 'package:itg_marvel_task/providers/characters_provider.dart';
import 'package:itg_marvel_task/screens/character_details_screen.dart';
import 'package:itg_marvel_task/utils/dimens.dart';
import 'package:itg_marvel_task/utils/navigations.dart';
import 'package:itg_marvel_task/widgets/divider_widget.dart';

import 'package:itg_marvel_task/widgets/loading_widget.dart';

import 'package:itg_marvel_task/widgets/search_box_widget.dart';
import 'package:itg_marvel_task/widgets/search_row_widget.dart';
import 'package:provider/provider.dart';

class CharacterSearchScreen extends StatefulWidget {
  const CharacterSearchScreen({Key? key}) : super(key: key);

  @override
  _CharacterSearchScreenState createState() => _CharacterSearchScreenState();
}

class _CharacterSearchScreenState extends State<CharacterSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CharactersProvider>(
      builder: (context, charactersProvider, child) {
        return Scaffold(
          backgroundColor: Colors.grey.shade800,
          appBar: AppBar(
              backgroundColor: kBlackColor,
              automaticallyImplyLeading: false,
              toolbarHeight: setHeight(context, 0.1),
              title: SearchBoxWidget(
                charactersProvider: charactersProvider,
                searchController: _searchController,
              )),
          body: charactersProvider.isLoading
              ? const LoadingWidget()
              : SizedBox(
                  height: double.infinity,
                  child: ListView.separated(physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            navigateTo(
                                context,
                                CharacterDetailsScreen(
                                    characterModel: charactersProvider
                                        .charactersSearchList[index]));
                          },
                          child: Container(
                            height: setHeight(context, 0.1),
                            color: Colors.grey.shade900,
                            child: SearchRowWidget(
                              charactersSearchList: charactersProvider
                                  .charactersSearchList[index],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const DividerWidget();
                      },
                      itemCount:
                          charactersProvider.charactersSearchList.length),
                ),
        );
      },
    );
  }
}
