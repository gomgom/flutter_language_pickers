import 'package:language_pickers/languages.dart';

/// Helpers of this package.
class LanguagePickerUtils {
  /// Finds a language by its ISO 639-1 code.
  @Deprecated('Use Language.fromIsoCode instead. Will be removed in 0.5.0.')
  static Language getLanguageByIsoCode(String isoCode) =>
      Language.fromIsoCode(isoCode);

  /// The asset path of the flag image of [isoCode].
  static String getFlagImageAssetPath(String isoCode) {
    return "assets/${isoCode.toLowerCase()}.png";
  }
}
