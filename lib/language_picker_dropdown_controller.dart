import 'package:flutter/foundation.dart';

import 'languages.dart';

/// Lets you read and change the selection of a [LanguagePickerDropdown] from
/// outside the widget.
///
/// ```dart
/// final controller = LanguagePickerDropdownController();
/// ...
/// LanguagePickerDropdown(controller: controller)
/// ...
/// controller.selectIsoCode('ko');   // the dropdown follows
/// print(controller.value.name);     // reads the current selection
/// ```
///
/// Call [dispose] when you are done with it.
class LanguagePickerDropdownController extends ValueNotifier<Language> {
  /// Creates a controller selecting [initialValue].
  ///
  /// [initialValue] defaults to [Languages.english].
  ///
  /// If the dropdown this controller is given to does not have the selected
  /// language in its list, the controller is moved to the language the
  /// dropdown ends up showing.
  LanguagePickerDropdownController({Language? initialValue})
      : super(initialValue ?? Languages.english);

  /// Selects the language with the given ISO 639-1 code.
  ///
  /// Throws an [ArgumentError] if there is no such language.
  /// See [Language.fromIsoCode].
  void selectIsoCode(String isoCode) => value = Language.fromIsoCode(isoCode);
}
