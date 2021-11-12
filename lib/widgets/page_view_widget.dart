import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itg_marvel_task/constants/assets.dart';
import 'package:itg_marvel_task/constants/colors.dart';
import 'package:itg_marvel_task/constants/constants.dart';
import 'package:itg_marvel_task/providers/character_types_provider.dart';
import 'package:itg_marvel_task/utils/dimens.dart';
import 'package:itg_marvel_task/widgets/text_widget.dart';

import 'loading_widget.dart';

class PageViewWidget extends StatefulWidget {
  final CharacterTypesProvider characterTypesProvider;
  final CharactersTypes? charactersTypes;

  const PageViewWidget(
      {Key? key,
      required this.characterTypesProvider,
      required this.charactersTypes})
      : super(key: key);

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  int currentImageIndex = 1;
  List list = [];
  @override
  void initState() {
    super.initState();
    if (widget.charactersTypes == CharactersTypes.comics) {
      list = widget.characterTypesProvider.characterComicsList;
    } else if (widget.charactersTypes == CharactersTypes.series) {
      list = widget.characterTypesProvider.characterSeriesList;
    } else if (widget.charactersTypes == CharactersTypes.stories) {
      list = widget.characterTypesProvider.characterStoriesList;
    } else if (widget.charactersTypes == CharactersTypes.events) {
      list = widget.characterTypesProvider.characterEventsList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: AlertDialog(
        backgroundColor: Colors.grey.shade800,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(
                Icons.close,
                color: kWhiteColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: setHeight(context, 0.7),
              child: Padding(
                padding: EdgeInsets.only(top: setHeight(context, 0.1)),
                child: PageView(
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (value) {
                    setState(() {
                      currentImageIndex = value + 1;
                    });
                  },
                  children: list.map((e) {
                    return Column(
                      children: [
                        e.thumbnail == null
                            ? CachedNetworkImage(
                          width: double.infinity,
                          height: setHeight(context, 0.5),
                                imageUrl: kPlaceholderImage,
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error,
                                  color: kRedColor,
                                ),fit: BoxFit.fill,
                                placeholder: (context, url) => const Center(
                                  child: LoadingWidget(),
                                ),
                              )
                            : CachedNetworkImage(
                                width: double.infinity,
                                height: setHeight(context, 0.5),
                                imageUrl: e.thumbnail!.path! +
                                    "." +
                                    e.thumbnail!.extension!,
                                fit: BoxFit.fill,
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error,
                                  color: kRedColor,
                                ),
                                placeholder: (context, url) => const Center(
                                  child: LoadingWidget(),
                                ),
                              ),
                        SizedBox(
                          height: setHeight(context, 0.02),
                        ),
                        Center(
                          child: TextWidget(
                            color: kWhiteColor,
                            sizeByPercent: 0.03,
                            text: e.title!,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: setHeight(context, 0.02),
                        ),
                        Center(
                          child: TextWidget(
                              color: kWhiteColor,
                              sizeByPercent: 0.03,
                              text:
                                  "$currentImageIndex / ${list.length.toString()}"),
                        )
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
