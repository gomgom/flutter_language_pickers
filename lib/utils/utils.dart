import 'package:language_pickers/languages.dart';
import 'package:language_pickers/language.dart';
import 'package:flutter/widgets.dart';

class LanguagePickerUtils {
  static Language getLanguageByIsoCode(String isoCode) {
    final _languages =
        languagesList.map((item) => Language.fromMap(item)).toList();
    try {
      return _languages
          .where((language) =>
              language.isoCode.toLowerCase() == isoCode.toLowerCase())
          .toList()[0];
    } catch (error) {
      throw Exception("The initialValue provided is not a supported iso code!");
    }
  }

  static String getFlagImageAssetPath(String isoCode) {
    return "assets/${isoCode.toLowerCase()}.png";
  }

  /* static Widget getDefaultFlagImage(Language language) {
    return Image.asset(
      LanguagePickerUtils.getFlagImageAssetPath(language.isoCode),
      height: 20.0,
      width: 30.0,
      fit: BoxFit.fill,
      package: "language_pickers",
    );
  } */
}
