import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itg_marvel_task/constants/colors.dart';
import 'package:itg_marvel_task/models/character_model.dart';
import 'package:itg_marvel_task/utils/dimens.dart';
import 'package:itg_marvel_task/widgets/loading_widget.dart';
import 'package:itg_marvel_task/widgets/text_widget.dart';

class SearchRowWidget extends StatelessWidget {
  final CharacterResult charactersSearchList;
  const SearchRowWidget({Key? key, required this.charactersSearchList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          imageUrl: charactersSearchList.thumbnail!
              .path! +
              "." +
              charactersSearchList.thumbnail!
                  .extension!,
          width: setWidth(context,0.2),
          height: setHeight(context, 0.1),
          fit: BoxFit.fill,
          errorWidget: (context, url, error) =>
              const Icon(Icons.error,color: kRedColor,),
          placeholder: (context, url) => const Center(
            child: LoadingWidget(),
          ),
        ),
        SizedBox(
          width: setWidth(context,0.02),
        ),
        TextWidget(color: kWhiteColor, sizeByPercent: k14TextSize, text: charactersSearchList.name!,)
      ],
    );
  }
}
