import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itg_marvel_task/utils/api.dart';

import 'base_repo.dart';

class CharactersRepository extends BaseRepository {
  static CharactersRepository? _instance;

  CharactersRepository._();

  static CharactersRepository getInstance() {
    _instance ??= CharactersRepository._();
    return _instance!;
  }

  getCharacters({int? limit}) async {
    var result = await dio.makeGetRequest(
      endPoint: API.kGetCharactersEndPoint,
      query: {
        "limit": limit,
      },
    );
    debugPrint("Repo getCharacters result : $result");
    return result;
  }

  getCharacter({int? limit, String? characterName}) async {
    var result = await dio.makeGetRequest(
      endPoint: API.kGetCharactersEndPoint,
      query: {"limit": limit, "nameStartsWith": characterName},
    );
    debugPrint("Repo getCharacters result : $result");
    return result;
  }

  getCharacterTypes({int? limit, int? characterId, String? type}) async {
    var result = await dio.makeGetRequest(
      endPoint: "${API.kGetCharactersEndPoint}/$characterId/$type",
      query: {
        "limit": limit,
      },
    );
    debugPrint("Repo getCharacters result : $result");
    return result;
  }
}
