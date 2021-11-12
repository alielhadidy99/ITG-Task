import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itg_marvel_task/models/character_comics_model.dart';
import 'package:itg_marvel_task/models/character_events_model.dart';
import 'package:itg_marvel_task/models/character_series_model.dart';
import 'package:itg_marvel_task/models/character_stories_model.dart';
import 'package:itg_marvel_task/utils/dimens.dart';
import 'package:itg_marvel_task/widgets/loading_widget.dart';
import '../models/character_model.dart';

class ItemList extends StatefulWidget {
  final List<CharacterComicsResult>? characterComicsList;
  final List<CharacterStoriesResult>? characterStoriesList;
  final List<CharacterSeriesResult>? characterSeriesList;
  final List<CharacterEventsResult>? characterEventsList;
  final List<CharacterResult>? charactersList;
  final bool showLoad;
  final bool? isCharacters;
  final bool? isComics;
  final bool? isSeries;
  final bool? isStories;
  final Axis scrollDirection;
  final IndexedWidgetBuilder itemBuilder;

  const ItemList({
    Key? key,
    this.charactersList,
    required this.showLoad,
    required this.itemBuilder,
    this.characterComicsList,
    required this.scrollDirection,
    this.isCharacters = false,
    this.characterStoriesList,
    this.characterSeriesList,
    this.characterEventsList,
    this.isComics= false,
    this.isSeries= false,
    this.isStories= false,
  }) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.separated(
              scrollDirection: widget.scrollDirection,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) {
                return widget.isCharacters!
                    ? const SizedBox()
                    : SizedBox(
                  width: setWidth(context, 0.005),
                );
              },
              itemCount: widget.isComics!
                  ? widget.characterComicsList!.length
                  : widget.isCharacters! ? widget.charactersList!.length : widget
                  .isSeries! ? widget.characterSeriesList!.length : widget
                  .isStories! ? widget.characterStoriesList!.length : widget
                  .characterEventsList!.length,
              itemBuilder : widget.itemBuilder),
        ),
        Padding(
          padding: EdgeInsets.only(top: setHeight(context, 0.38)),
          child: Visibility(
            visible: widget.showLoad,
            child: const LoadingWidget(),
          ),
        ),
      ],
    );
  }
}
