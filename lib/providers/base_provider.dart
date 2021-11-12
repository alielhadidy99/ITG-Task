import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class BaseProvider with ChangeNotifier {
  static BaseProvider get(context) =>
      Provider.of<BaseProvider>(context, listen: false);
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

//Check ApiCall if success or not
  static bool checkAPIDataWithErrorSuccessCallback(
      {required res, Function? onSuccess, Function? onError}) {
    debugPrint('response is $res');
    debugPrint('code is ${res['code']}');
    if (res["code"] == 200) {
      if (onSuccess != null) onSuccess(res["status"]);
      return true;
    } else {
      if (res["code"] != 200) {
        if (onError != null) {
          onError(res);
        }
      }
      return false;
    }
  }
}
