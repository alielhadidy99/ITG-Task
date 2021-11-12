import 'package:cached_network_image/cached_network_image.dart';
import 'package:clippy_flutter/paralellogram.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itg_marvel_task/constants/colors.dart';
import 'package:itg_marvel_task/models/character_model.dart';
import 'package:itg_marvel_task/utils/dimens.dart';
import 'package:itg_marvel_task/widgets/loading_widget.dart';
import 'package:itg_marvel_task/widgets/text_widget.dart';
class CharacterWidget extends StatelessWidget {
  final CharacterResult characterResult;
  const CharacterWidget({Key? key, required this.characterResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        SizedBox(
            height: setHeight(context,0.24),
            width: double.infinity,
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: characterResult.thumbnail!
                  .path! +
                  "." +
                  characterResult .thumbnail!.extension!,
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: kRedColor,
              ),
              placeholder: (context, url) => const Center(
                child:LoadingWidget(),
              ),
            )),
        Positioned(
          top: setHeight(context, 0.165),
          right: setWidth(context, 0.5),
          child: Parallelogram(
            cutLength: 10.0,
            edge: Edge.RIGHT,
            child: Container(
              color: kWhiteColor,
              width: setWidth(context, 0.4),
              height: setHeight(context, 0.06),
              child: Center(
                child: TextWidget(
                text:  characterResult.name!,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  textOverflow: TextOverflow.ellipsis,
                      color: kBlackColor,
                      sizeByPercent:k14TextSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
