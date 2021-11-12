import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itg_marvel_task/models/character_model.dart';
import 'package:itg_marvel_task/repos/characters_repository.dart';
import 'package:itg_marvel_task/utils/api.dart';
import 'package:itg_marvel_task/utils/locator.dart';
import 'package:provider/provider.dart';
import 'base_provider.dart';

class CharactersProvider extends BaseProvider {
  static CharactersProvider get(context) =>
      Provider.of<CharactersProvider>(context, listen: false);
  final CharactersRepository _characterRepository =
      locator<CharactersRepository>();

  CharactersProvider(int limit) {
    _getItems(limit);
  }

  _getItems(int limit) async {
    await getCharacters(limit: limit);
  }

  List<CharacterResult> charactersList = [];
  int charactersCountLimit = 0;

  getCharacters(
      {int? limit = API.kPerPage,
      Function? onSuccess,
      Function? onError}) async {
    try {
      isLoading = true;
      var response = await _characterRepository.getCharacters(limit: limit);
      if (response.data['status'] == "Ok") {
        charactersList = [];
        response.data['data']["results"].forEach((item) {
          charactersList.add(CharacterResult.fromJson(item));
        });
        charactersCountLimit =100;
      }
      isLoading = false;
      notifyListeners();
      debugPrint("Provider getCharacters done");
      return BaseProvider.checkAPIDataWithErrorSuccessCallback(
          res: response.data, onSuccess: onSuccess, onError: onError);
    } on DioError catch (e) {
      debugPrint("Provider getCharacters dioError${e.response!.data!}");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Provider getCharacters catchError${e.toString()}');
      isLoading = false;
      notifyListeners();
    }
  }

  List<CharacterResult> charactersSearchList = [];
  int searchCountLimit = 0;

  getCharacter(
      {int? limit = API.kPerPage,
      Function? onSuccess,
      Function? onError,
      String? characterName}) async {
    try {
      isLoading = true;
      var response = await _characterRepository.getCharacter(
          limit: limit, characterName: characterName);
      if (response.data['status'] == "Ok") {
        charactersSearchList = [];
        response.data['data']["results"].forEach((item) {
          charactersSearchList.add(CharacterResult.fromJson(item));
        });
        searchCountLimit = 100;
      }
      isLoading = false;
      notifyListeners();
      debugPrint("Provider getSearchCharacters done");
      return BaseProvider.checkAPIDataWithErrorSuccessCallback(
          res: response.data, onSuccess: onSuccess, onError: onError);
    } on DioError catch (e) {
      debugPrint("Provider getSearchCharacters dioError${e.response!.data!}");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Provider getSearchCharacters catchError${e.toString()}');
      isLoading = false;
      notifyListeners();
    }
  }
}
