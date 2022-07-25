import 'package:flutter/cupertino.dart';
// ده كلاس بيعمل  loading للصفحه
class ModelHud extends ChangeNotifier {
  bool isLoading = false;

  changeisLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
