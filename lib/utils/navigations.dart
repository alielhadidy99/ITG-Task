import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

navigateTo(BuildContext context, createPage) async {
  return await Navigator.of(context)
      .push(MaterialPageRoute(builder: (BuildContext context) {
    return createPage;
  }));
}
