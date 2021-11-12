import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itg_marvel_task/constants/assets.dart';
import 'package:itg_marvel_task/constants/colors.dart';
import 'package:itg_marvel_task/providers/characters_provider.dart';
import 'package:itg_marvel_task/screens/character_search_screen.dart';
import 'package:itg_marvel_task/utils/dimens.dart';
import 'package:itg_marvel_task/utils/navigations.dart';
import 'package:itg_marvel_task/widgets/character_widget.dart';
import 'package:provider/provider.dart';
import '../widgets/items_list.dart';
import '../widgets/scrollable_pagination_content.dart';
import 'character_details_screen.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        backgroundColor: kBlackColor,
        title: Image.asset(
          kMarvelImage,
          width: setWidth(context, 0.17),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: renderFontSizeFromPixels(context, kPadding10)),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                color: kRedColor,
              ),
              onPressed: () {
                navigateTo(context, const CharacterSearchScreen());
              },
            ),
          ),
        ],
      ),
      body: Consumer<CharactersProvider>(
        builder: (context, charactersProvider, child) {
          return AbsorbPointer(
              absorbing: charactersProvider.isLoading,
              child: ScrollViewWithPaginationWidget(
                scrollDirection: Axis.vertical,
                contentWidget: ItemList(
               isCharacters: true,
                  scrollDirection: Axis.vertical,
                  charactersList: charactersProvider.charactersList,
                  showLoad: charactersProvider.isLoading,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          navigateTo(
                              context,
                              CharacterDetailsScreen(
                                characterModel:
                                    charactersProvider.charactersList[index],
                              ));
                        },
                        child: CharacterWidget(
                          characterResult:
                              charactersProvider.charactersList[index],
                        ));
                  },
                ),
                onPagination: (int page) async {
                  return await charactersProvider.getCharacters(limit: page);
                },
                maxCount: charactersProvider.charactersCountLimit,
              ));
        },
      ),
    );
  }
}
