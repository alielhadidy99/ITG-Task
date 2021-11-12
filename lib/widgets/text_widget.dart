import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itg_marvel_task/utils/dimens.dart';

class TextWidget extends StatelessWidget {
  final Color color;
  final double sizeByPercent;
  final String text;
  final FontWeight fontWeight;
  final int maxLines;
  final TextOverflow textOverflow;
  final TextAlign textAlign;

  const TextWidget(
      {Key? key,
      required this.color,
      required this.sizeByPercent,
      this.fontWeight = FontWeight.normal,
      required this.text,
      this.maxLines = 1,
      this.textOverflow = TextOverflow.ellipsis, this.textAlign=TextAlign.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color,
          fontSize: renderFontSizeFromPixels(context, sizeByPercent),
          fontWeight: fontWeight),
    );
  }
}
