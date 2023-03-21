import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProviderLocalisation extends ChangeNotifier {
  // bool select = true;

  void editLanquage(BuildContext context) async {
    if (context.locale == const Locale('ru')) {
      await context.setLocale(const Locale('en'));
    } else {
      await context.setLocale(const Locale('ru'));
    }
    // select = !select;
    notifyListeners();
  }
}
