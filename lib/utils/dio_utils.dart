import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itg_marvel_task/utils/api.dart';
import 'package:crypto/crypto.dart' as crypto;

class DioUtils {
  final Dio _dio;
  static DioUtils? _instance;

  DioUtils._(this._dio);

  static DioUtils getInstance() {
    if (_instance == null) {
      Dio dio = Dio();
      _instance = DioUtils._(dio);
    }
    return _instance!;
  }

//Get Request
  makeGetRequest({
    String? endPoint,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    Response response;
    try {
      if (headers != null) _dio.options.headers.addAll(headers);
      if (query != null) _dio.options.queryParameters.addAll(query);
      _dio.options.headers = {
        "Content-Type": "application/json; charset=utf-8"
      };
      _dio.options.queryParameters = {
        "apikey": API.publicKey,
        "ts": DateTime.now().millisecondsSinceEpoch.toString(),
        "hash": hex.encode(crypto.md5
            .convert(const Utf8Encoder().convert(
                "${DateTime.now().millisecondsSinceEpoch.toString()}${API.privateKey}${API.publicKey}"))
            .bytes),
      };
      debugPrint('MakeGetRequest headers are #${_dio.options.headers}');
      debugPrint('MakeGetRequest endPoint are #$endPoint');
      debugPrint('MakeGetRequest query are #${_dio.options.queryParameters}');
      response = await _dio.get(endPoint!, queryParameters: query);
      debugPrint('MakeGetRequest done');
      return response;
    } on DioError catch (e) {
      debugPrint('MakeGetRequest dioError${e.response!}');
      return e.response!;
    } catch (e) {
      debugPrint('MakeGetRequest catch${e.toString()}');
      return e.toString();
    }
  }
}
