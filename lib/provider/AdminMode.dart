import 'package:flutter/cupertino.dart';

// ده class ان لو الشخص اللي داخل admin مش user دخله بجميع tools المتاحه لل admin
class AdminMode extends ChangeNotifier {
  bool isAdmin = false;
  changeIsAdmin(bool value) {
    isAdmin = value;
    notifyListeners();
  }
}
