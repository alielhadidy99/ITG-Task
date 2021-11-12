import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itg_marvel_task/constants/assets.dart';
import 'package:itg_marvel_task/constants/colors.dart';
import 'package:itg_marvel_task/constants/constants.dart';
import 'package:itg_marvel_task/models/character_model.dart';
import 'package:itg_marvel_task/providers/character_types_provider.dart';
import 'package:itg_marvel_task/utils/api.dart';
import 'package:itg_marvel_task/utils/dimens.dart';
import 'package:itg_marvel_task/utils/navigations.dart';

import 'package:itg_marvel_task/widgets/character_details_bottom.dart';
import 'package:itg_marvel_task/widgets/character_details_top.dart';

import 'package:itg_marvel_task/widgets/items_list.dart';
import 'package:itg_marvel_task/widgets/loading_widget.dart';
import 'package:itg_marvel_task/widgets/page_view_widget.dart';
import 'package:itg_marvel_task/widgets/scrollable_pagination_content.dart';
import 'package:itg_marvel_task/widgets/text_widget.dart';

import 'package:provider/provider.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final CharacterResult characterModel;

  const CharacterDetailsScreen({Key? key, required this.characterModel})
      : super(key: key);

  @override
  _CharacterDetailsScreenState createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    kBrownColor.withOpacity(0.95), BlendMode.srcATop),
                image: NetworkImage(widget.characterModel.thumbnail!.path! +
                    "." +
                    widget.characterModel.thumbnail!.extension!),
                fit: BoxFit.fill)),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,color: kWhiteColor,),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: kBlackColor.withOpacity(0.8),
                expandedHeight: setHeight(context, 0.3),
                elevation: 0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: TextWidget(
                    text: widget.characterModel.name!,
                    sizeByPercent: 0.04,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  centerTitle: true,
                  background: CachedNetworkImage(
                    width: double.infinity,
                    imageUrl: widget.characterModel.thumbnail!.path! +
                        "." +
                        widget.characterModel.thumbnail!.extension!,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: kRedColor,
                    ),
                    placeholder: (context, url) => const Center(
                      child: LoadingWidget(),
                    ),
                  ),
                )),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.only(
                        top: renderFontSizeFromPixels(context, kPadding24),
                        left: renderFontSizeFromPixels(context, kPadding24)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CharacterDetailsTop(
                          characterResult: widget.characterModel,
                        ),
                        ChangeNotifierProvider(
                            create: (_) => CharacterTypesProvider(
                                API.kPerPage, widget.characterModel.id!),
                            child: Consumer<CharacterTypesProvider>(
                              builder:
                                  (context, characterTypesProvider, child) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    characterTypesProvider
                                            .characterComicsList.isEmpty
                                        ? const SizedBox()
                                        : InkWell(
                                            onTap: () {
                                              navigateTo(
                                                  context,
                                                  PageViewWidget(
                                                    characterTypesProvider:
                                                        characterTypesProvider,
                                                    charactersTypes:
                                                        CharactersTypes.comics,
                                                  ));
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(
                                                  text: tr("comics"),
                                                  color: kRedColor,
                                                  sizeByPercent: k16TextSize,
                                                  fontWeight: FontWeight.bold,
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                  height:
                                                      setHeight(context, 0.01),
                                                ),
                                                SizedBox(
                                                  height:
                                                      setHeight(context, 0.24),
                                                  child: AbsorbPointer(
                                                      absorbing:
                                                          characterTypesProvider
                                                              .isLoading,
                                                      child:
                                                          ScrollViewWithPaginationWidget(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        contentWidget: ItemList(
                                                          isComics: true,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          characterComicsList:
                                                              characterTypesProvider
                                                                  .characterComicsList,
                                                          showLoad:
                                                              characterTypesProvider
                                                                  .isLoading,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return SizedBox(
                                                              width: setWidth(
                                                                  context,
                                                                  0.25),
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    width: setWidth(
                                                                        context,
                                                                        0.25),
                                                                    height: setHeight(
                                                                        context,
                                                                        0.19),
                                                                    child: characterTypesProvider.characterComicsList[index].thumbnail ==
                                                                            null
                                                                        ? CachedNetworkImage(
                                                                            imageUrl:
                                                                                kPlaceholderImage,
                                                                            errorWidget: (context, url, error) =>
                                                                                const Icon(
                                                                              Icons.error,
                                                                              color: kRedColor,
                                                                            ),
                                                                            placeholder: (context, url) =>
                                                                                const Center(
                                                                              child: LoadingWidget(),
                                                                            ),
                                                                          )
                                                                        : CachedNetworkImage(
                                                                            imageUrl: characterTypesProvider.characterComicsList[index].thumbnail!.path! +
                                                                                "." +
                                                                                characterTypesProvider.characterComicsList[index].thumbnail!.extension!,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                            errorWidget: (context, url, error) =>
                                                                                const Icon(
                                                                              Icons.error,
                                                                              color: kRedColor,
                                                                            ),
                                                                            placeholder: (context, url) =>
                                                                                const Center(
                                                                              child: LoadingWidget(),
                                                                            ),
                                                                          ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: setHeight(
                                                                        context,
                                                                        0.005),
                                                                  ),
                                                                  TextWidget(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      text: characterTypesProvider
                                                                          .characterComicsList[
                                                                              index]
                                                                          .title!,
                                                                      maxLines:
                                                                          2,
                                                                      textOverflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      color:
                                                                          kWhiteColor,
                                                                      sizeByPercent:
                                                                          k14TextSize,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        onPagination:
                                                            (int page) async {
                                                          return await characterTypesProvider
                                                              .getCharactersComics(
                                                                  limit: page,
                                                                  characterId:
                                                                      widget
                                                                          .characterModel
                                                                          .id!);
                                                        },
                                                        maxCount:
                                                            characterTypesProvider
                                                                .comicsCountLimit,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                    characterTypesProvider
                                            .characterSeriesList.isEmpty
                                        ? const SizedBox()
                                        : InkWell(
                                            onTap: () {
                                              navigateTo(
                                                  context,
                                                  PageViewWidget(
                                                    characterTypesProvider:
                                                        characterTypesProvider,
                                                    charactersTypes:
                                                        CharactersTypes.series,
                                                  ));
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(
                                                  text: tr("series"),
                                                  color: kRedColor,
                                                  sizeByPercent: k16TextSize,
                                                  fontWeight: FontWeight.bold,
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                  height:
                                                      setHeight(context, 0.01),
                                                ),
                                                SizedBox(
                                                  height:
                                                      setHeight(context, 0.24),
                                                  child: AbsorbPointer(
                                                      absorbing:
                                                          characterTypesProvider
                                                              .isLoading,
                                                      child:
                                                          ScrollViewWithPaginationWidget(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        contentWidget: ItemList(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          isSeries: true,
                                                          characterSeriesList:
                                                              characterTypesProvider
                                                                  .characterSeriesList,
                                                          showLoad:
                                                              characterTypesProvider
                                                                  .isLoading,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return SizedBox(
                                                              width: setWidth(
                                                                  context,
                                                                  0.25),
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    width: setWidth(
                                                                        context,
                                                                        0.25),
                                                                    height: setHeight(
                                                                        context,
                                                                        0.19),
                                                                    child: characterTypesProvider.characterSeriesList[index].thumbnail ==
                                                                            null
                                                                        ? CachedNetworkImage(
                                                                            imageUrl:
                                                                                kPlaceholderImage,
                                                                            errorWidget: (context, url, error) =>
                                                                                const Icon(
                                                                              Icons.error,
                                                                              color: kRedColor,
                                                                            ),
                                                                            placeholder: (context, url) =>
                                                                                const Center(
                                                                              child: LoadingWidget(),
                                                                            ),
                                                                          )
                                                                        : CachedNetworkImage(
                                                                            imageUrl: characterTypesProvider.characterSeriesList[index].thumbnail!.path! +
                                                                                "." +
                                                                                characterTypesProvider.characterSeriesList[index].thumbnail!.extension!,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                            errorWidget: (context, url, error) =>
                                                                                const Icon(
                                                                              Icons.error,
                                                                              color: kRedColor,
                                                                            ),
                                                                            placeholder: (context, url) =>
                                                                                const Center(
                                                                              child: LoadingWidget(),
                                                                            ),
                                                                          ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: setHeight(
                                                                        context,
                                                                        0.005),
                                                                  ),
                                                                  TextWidget(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      text: characterTypesProvider
                                                                          .characterSeriesList[
                                                                              index]
                                                                          .title!,
                                                                      maxLines:
                                                                          2,
                                                                      textOverflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      color:
                                                                          kWhiteColor,
                                                                      sizeByPercent:
                                                                          k14TextSize,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        onPagination:
                                                            (int page) async {
                                                          return await characterTypesProvider
                                                              .getCharactersSeries(
                                                                  limit: page,
                                                                  characterId:
                                                                      widget
                                                                          .characterModel
                                                                          .id!);
                                                        },
                                                        maxCount:
                                                            characterTypesProvider
                                                                .seriesCountLimit,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                    characterTypesProvider
                                            .characterStoriesList.isEmpty
                                        ? const SizedBox()
                                        : InkWell(
                                            onTap: () {
                                              navigateTo(
                                                  context,
                                                  PageViewWidget(
                                                    characterTypesProvider:
                                                        characterTypesProvider,
                                                    charactersTypes:
                                                        CharactersTypes.stories,
                                                  ));
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(
                                                  text: tr("stories"),
                                                  color: kRedColor,
                                                  sizeByPercent: k16TextSize,
                                                  fontWeight: FontWeight.bold,
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                  height:
                                                      setHeight(context, 0.01),
                                                ),
                                                SizedBox(
                                                  height:
                                                      setHeight(context, 0.24),
                                                  child: AbsorbPointer(
                                                      absorbing:
                                                          characterTypesProvider
                                                              .isLoading,
                                                      child:
                                                          ScrollViewWithPaginationWidget(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        contentWidget: ItemList(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          isStories: true,
                                                          characterStoriesList:
                                                              characterTypesProvider
                                                                  .characterStoriesList,
                                                          showLoad:
                                                              characterTypesProvider
                                                                  .isLoading,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return SizedBox(
                                                              width: setWidth(
                                                                  context,
                                                                  0.25),
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    width: setWidth(
                                                                        context,
                                                                        0.25),
                                                                    height: setHeight(
                                                                        context,
                                                                        0.19),
                                                                    child: characterTypesProvider.characterStoriesList[index].thumbnail ==
                                                                            null
                                                                        ? CachedNetworkImage(
                                                                            imageUrl:
                                                                                kPlaceholderImage,
                                                                            errorWidget: (context, url, error) =>
                                                                                const Icon(
                                                                              Icons.error,
                                                                              color: kRedColor,
                                                                            ),
                                                                            placeholder: (context, url) =>
                                                                                const Center(
                                                                              child: LoadingWidget(),
                                                                            ),
                                                                          )
                                                                        : CachedNetworkImage(
                                                                            imageUrl: characterTypesProvider.characterStoriesList[index].thumbnail!.path! +
                                                                                "." +
                                                                                characterTypesProvider.characterStoriesList[index].thumbnail!.extension!,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                            errorWidget: (context, url, error) =>
                                                                                const Icon(
                                                                              Icons.error,
                                                                              color: kRedColor,
                                                                            ),
                                                                            placeholder: (context, url) =>
                                                                                const Center(
                                                                              child: LoadingWidget(),
                                                                            ),
                                                                          ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: setHeight(
                                                                        context,
                                                                        0.005),
                                                                  ),
                                                                  TextWidget(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      text: characterTypesProvider
                                                                          .characterStoriesList[
                                                                              index]
                                                                          .title!,
                                                                      maxLines:
                                                                          2,
                                                                      textOverflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      color:
                                                                          kWhiteColor,
                                                                      sizeByPercent:
                                                                          k14TextSize,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        onPagination:
                                                            (int page) async {
                                                          return await characterTypesProvider
                                                              .getCharactersStories(
                                                                  limit: page,
                                                                  characterId:
                                                                      widget
                                                                          .characterModel
                                                                          .id!);
                                                        },
                                                        maxCount:
                                                            characterTypesProvider
                                                                .storiesCountLimit,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                    characterTypesProvider
                                            .characterEventsList.isEmpty
                                        ? const SizedBox()
                                        : InkWell(
                                            onTap: () {
                                              navigateTo(
                                                  context,
                                                  PageViewWidget(
                                                    characterTypesProvider:
                                                        characterTypesProvider,
                                                    charactersTypes:
                                                        CharactersTypes.events,
                                                  ));
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(
                                                  text: tr("events"),
                                                  color: kRedColor,
                                                  sizeByPercent: k16TextSize,
                                                  fontWeight: FontWeight.bold,
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                  height:
                                                      setHeight(context, 0.01),
                                                ),
                                                SizedBox(
                                                  height:
                                                      setHeight(context, 0.24),
                                                  child: AbsorbPointer(
                                                      absorbing:
                                                          characterTypesProvider
                                                              .isLoading,
                                                      child:
                                                          ScrollViewWithPaginationWidget(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        contentWidget: ItemList(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          characterEventsList:
                                                              characterTypesProvider
                                                                  .characterEventsList,
                                                          showLoad:
                                                              characterTypesProvider
                                                                  .isLoading,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return SizedBox(
                                                              width: setWidth(
                                                                  context,
                                                                  0.25),
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    width: setWidth(
                                                                        context,
                                                                        0.25),
                                                                    height: setHeight(
                                                                        context,
                                                                        0.19),
                                                                    child: characterTypesProvider.characterEventsList[index].thumbnail ==
                                                                            null
                                                                        ? CachedNetworkImage(
                                                                            imageUrl:
                                                                                kPlaceholderImage,
                                                                            errorWidget: (context, url, error) =>
                                                                                const Icon(
                                                                              Icons.error,
                                                                              color: kRedColor,
                                                                            ),
                                                                            placeholder: (context, url) =>
                                                                                const Center(
                                                                              child: LoadingWidget(),
                                                                            ),
                                                                          )
                                                                        : CachedNetworkImage(
                                                                            imageUrl: characterTypesProvider.characterEventsList[index].thumbnail!.path! +
                                                                                "." +
                                                                                characterTypesProvider.characterEventsList[index].thumbnail!.extension!,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                            errorWidget: (context, url, error) =>
                                                                                const Icon(
                                                                              Icons.error,
                                                                              color: kRedColor,
                                                                            ),
                                                                            placeholder: (context, url) =>
                                                                                const Center(
                                                                              child: LoadingWidget(),
                                                                            ),
                                                                          ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: setHeight(
                                                                        context,
                                                                        0.005),
                                                                  ),
                                                                  TextWidget(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      text: characterTypesProvider
                                                                          .characterEventsList[
                                                                              index]
                                                                          .title!,
                                                                      maxLines:
                                                                          2,
                                                                      textOverflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      color:
                                                                          kWhiteColor,
                                                                      sizeByPercent:
                                                                          k14TextSize,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        onPagination:
                                                            (int page) async {
                                                          return await characterTypesProvider
                                                              .getCharactersEvents(
                                                                  limit: page,
                                                                  characterId:
                                                                      widget
                                                                          .characterModel
                                                                          .id!);
                                                        },
                                                        maxCount:
                                                            characterTypesProvider
                                                                .eventsCountLimit,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                    SizedBox(
                                      height: setHeight(context, 0.02),
                                    ),
                                    CharacterDetailsBottom(
                                        characterResult: widget.characterModel),
                                  ],
                                );
                              },
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
