import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itg_marvel_task/models/character_comics_model.dart';
import 'package:itg_marvel_task/models/character_events_model.dart';
import 'package:itg_marvel_task/models/character_stories_model.dart';
import 'package:itg_marvel_task/models/character_series_model.dart';
import 'package:itg_marvel_task/repos/characters_repository.dart';
import 'package:itg_marvel_task/utils/api.dart';
import 'package:itg_marvel_task/utils/locator.dart';
import 'package:provider/provider.dart';
import 'base_provider.dart';

class CharacterTypesProvider extends BaseProvider {
  static CharacterTypesProvider get(context) =>
      Provider.of<CharacterTypesProvider>(context, listen: false);
  final CharactersRepository _characterRepository =
      locator<CharactersRepository>();

  CharacterTypesProvider(int limit, int characterId) {
    _getItems(limit, characterId);
  }

  _getItems(int limit, int characterId) async {
    await getCharactersComics(limit: limit, characterId: characterId);
    await getCharactersEvents(limit: limit, characterId: characterId);
    await getCharactersSeries(limit: limit, characterId: characterId);
    await getCharactersStories(limit: limit, characterId: characterId);
  }

  List<CharacterComicsResult> characterComicsList = [];
  int comicsCountLimit = 0;

  getCharactersComics(
      {int? limit = API.kPerPage,
      Function? onSuccess,
      Function? onError,
      int? characterId}) async {
    try {
      isLoading = true;
      var response = await _characterRepository.getCharacterTypes(
          limit: limit, characterId: characterId, type: "comics");
      if (response.data['status'] == "Ok") {
        characterComicsList = [];
        response.data['data']["results"].forEach((item) {
          characterComicsList.add(CharacterComicsResult.fromJson(item));
        });
        comicsCountLimit = response.data['data']['total'];
      }
      isLoading = false;
      notifyListeners();
      debugPrint("Provider getCharacterComics done");
      return BaseProvider.checkAPIDataWithErrorSuccessCallback(
          res: response.data, onSuccess: onSuccess, onError: onError);
    } on DioError catch (e) {
      debugPrint("Provider getCharacterComics dioError${e.response!.data!}");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Provider getCharacterComics catchError${e.toString()}');
      isLoading = false;
      notifyListeners();
    }
  }

  List<CharacterEventsResult> characterEventsList = [];
  int eventsCountLimit = 0;

  getCharactersEvents(
      {int? limit = API.kPerPage,
      Function? onSuccess,
      Function? onError,
      int? characterId}) async {
    try {
      isLoading = true;
      var response = await _characterRepository.getCharacterTypes(
          limit: limit, characterId: characterId, type: "events");
      if (response.data['status'] == "Ok") {
        characterEventsList = [];
        response.data['data']["results"].forEach((item) {
          characterEventsList.add(CharacterEventsResult.fromJson(item));
        });
        eventsCountLimit = response.data['data']['total'];
      }
      isLoading = false;
      notifyListeners();
      debugPrint("Provider getCharacterEvents done");
      return BaseProvider.checkAPIDataWithErrorSuccessCallback(
          res: response.data, onSuccess: onSuccess, onError: onError);
    } on DioError catch (e) {
      debugPrint("Provider getCharacterEvents dioError${e.response!.data!}");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Provider getCharacterEvents catchError${e.toString()}');
      isLoading = false;
      notifyListeners();
    }
  }

  List<CharacterSeriesResult> characterSeriesList = [];
  int seriesCountLimit = 0;

  getCharactersSeries(
      {int? limit = API.kPerPage,
      Function? onSuccess,
      Function? onError,
      int? characterId}) async {
    try {
      isLoading = true;
      var response = await _characterRepository.getCharacterTypes(
          limit: limit, characterId: characterId, type: "series");
      if (response.data['status'] == "Ok") {
        characterSeriesList = [];
        response.data['data']["results"].forEach((item) {
          characterSeriesList.add(CharacterSeriesResult.fromJson(item));
        });
        seriesCountLimit = response.data['data']['total'];
      }
      isLoading = false;
      notifyListeners();
      debugPrint("Provider getCharacterSeries done");
      return BaseProvider.checkAPIDataWithErrorSuccessCallback(
          res: response.data, onSuccess: onSuccess, onError: onError);
    } on DioError catch (e) {
      debugPrint("Provider getCharacterSeries dioError${e.response!.data!}");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Provider getCharacterSeries catchError${e.toString()}');
      isLoading = false;
      notifyListeners();
    }
  }

  List<CharacterStoriesResult> characterStoriesList = [];
  int storiesCountLimit = 0;

  getCharactersStories(
      {int? limit = API.kPerPage,
      Function? onSuccess,
      Function? onError,
      int? characterId}) async {
    try {
      isLoading = true;
      var response = await _characterRepository.getCharacterTypes(
          limit: limit, characterId: characterId, type: "stories");
      if (response.data['status'] == "Ok") {
        characterStoriesList = [];
        response.data['data']["results"].forEach((item) {
          characterStoriesList.add(CharacterStoriesResult.fromJson(item));
        });
        storiesCountLimit = response.data['data']['total'];
      }
      isLoading = false;
      notifyListeners();
      debugPrint("Provider getCharacterStories done");
      return BaseProvider.checkAPIDataWithErrorSuccessCallback(
          res: response.data, onSuccess: onSuccess, onError: onError);
    } on DioError catch (e) {
      debugPrint("Provider getCharacterStories dioError${e.response!.data!}");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Provider getCharacterStories catchError${e.toString()}');
      isLoading = false;
      notifyListeners();
    }
  }
}
