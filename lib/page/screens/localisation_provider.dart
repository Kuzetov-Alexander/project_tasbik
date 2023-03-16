import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tasbix/generated/locale_keys.g.dart';


class ProviderLocalisation extends ChangeNotifier {
  bool select = true;

  void editLanquage(BuildContext context) {
    if (context.locale == const Locale('ru')) {
      context.setLocale(const Locale('en'));
    } else {
      context.setLocale(const Locale('ru'));
    }
    select = !select;
    notifyListeners();
  }

  String textLanquage(String activity) {
    return LocaleKeys.activity;
  }
}
