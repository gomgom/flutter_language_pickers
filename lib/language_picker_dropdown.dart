import 'package:flutter/foundation.dart' show listEquals;
import 'package:language_pickers/language_picker_dropdown_controller.dart';
import 'package:language_pickers/languages.dart';
import 'package:language_pickers/utils/typedefs.dart';
import 'package:flutter/material.dart';

///Provides a customizable [DropdownButton] for all languages
class LanguagePickerDropdown extends StatefulWidget {
  /// Creates a dropdown of languages.
  const LanguagePickerDropdown({
    super.key,
    this.itemBuilder,
    this.initialValue,
    this.onValuePicked,
    this.languages,
    this.controller,
    @Deprecated('Use languages instead. Will be removed in 0.5.0.')
    this.languagesList,
  }) : assert(languages == null || languagesList == null,
            'Use either languages or the deprecated languagesList, not both.');

  ///This function will be called to build the child of DropdownMenuItem
  ///If it is not provided, default one will be used which displays
  ///the name and the isoCode in a row.
  ///Check _buildDefaultMenuItem method for details.
  final ItemBuilder? itemBuilder;

  ///It should be one of the ISO 639-1 codes of [languages].
  ///
  ///Ignored when [controller] is given.
  final String? initialValue;

  ///This function will be called whenever a Language item is selected.
  final ValueChanged<Language>? onValuePicked;

  /// List of languages available in this picker.
  ///
  /// Defaults to [Languages.defaultLanguages]. Treat the list you pass as
  /// immutable: changing it in place does not rebuild the picker, while
  /// passing a different list does.
  final List<Language>? languages;

  /// Lets you read and change the selection from outside this widget.
  ///
  /// [initialValue] is ignored when this is given.
  final LanguagePickerDropdownController? controller;

  /// List of languages available in this picker, as maps.
  @Deprecated('Use languages instead. Will be removed in 0.5.0.')
  final List<Map<String, String>>? languagesList;

  @override
  State<LanguagePickerDropdown> createState() => _LanguagePickerDropdownState();
}

class _LanguagePickerDropdownState extends State<LanguagePickerDropdown> {
  late List<Language> _languages;
  late Language _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _languages = _resolveLanguages();
    assert(_languages.isNotEmpty, 'languages must not be empty.');
    _selectedLanguage = _resolveInitialLanguage();

    if (widget.controller != null) {
      _reconcileController();
      widget.controller!.addListener(_onControllerChanged);
    }
  }

  @override
  void didUpdateWidget(LanguagePickerDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onControllerChanged);
      widget.controller?.addListener(_onControllerChanged);
    }

    // listEquals, not identity: callers often build an equal list every frame.
    final bool languagesChanged =
        !listEquals(oldWidget.languages, widget.languages) ||
            !listEquals(
              // ignore: deprecated_member_use_from_same_package
              oldWidget.languagesList,
              // ignore: deprecated_member_use_from_same_package
              widget.languagesList,
            );
    if (languagesChanged) {
      _languages = _resolveLanguages();
      assert(_languages.isNotEmpty, 'languages must not be empty.');
    }

    final bool selectionInputChanged =
        oldWidget.controller != widget.controller ||
            oldWidget.initialValue != widget.initialValue;

    if (languagesChanged || selectionInputChanged) {
      // No setState(): didUpdateWidget is always followed by a rebuild.
      _selectedLanguage = _reresolveSelection(
        honourInitialValue: selectionInputChanged,
      );
      _reconcileController();
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    final Language value = widget.controller!.value;
    if (value == _selectedLanguage) return;
    if (!_languages.contains(value)) {
      // Never let the controller and the dropdown disagree: move the
      // controller back to the language on the screen.
      widget.controller!.value = _selectedLanguage;
      return;
    }
    setState(() => _selectedLanguage = value);
  }

  /// Moves the controller to [_selectedLanguage] when they disagree.
  ///
  /// The write waits for the end of the frame: this method runs during the
  /// build phase, and other listeners of the same controller may react to it
  /// with setState, which is not allowed while building.
  void _reconcileController() {
    final LanguagePickerDropdownController? controller = widget.controller;
    if (controller == null || controller.value == _selectedLanguage) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || widget.controller != controller) return;
      if (!_languages.contains(controller.value)) {
        controller.value = _selectedLanguage;
      }
    });
  }

  List<Language> _resolveLanguages() {
    final List<Language>? languages = widget.languages;
    if (languages != null) return languages;
    // ignore: deprecated_member_use_from_same_package
    final List<Map<String, String>>? legacy = widget.languagesList;
    if (legacy != null) return legacy.map(Language.fromMap).toList();
    return Languages.defaultLanguages;
  }

  /// Resolves the language to select at first.
  ///
  /// Only called from [State.initState], so that a wrong initialValue is loud.
  Language _resolveInitialLanguage() {
    final Language? controllerValue = widget.controller?.value;
    if (controllerValue != null) {
      return _languages.contains(controllerValue)
          ? controllerValue
          : _languages.first;
    }

    final String? initialValue = widget.initialValue;
    if (initialValue == null) return _languages.first;
    for (final Language language in _languages) {
      if (language.isoCode == initialValue) return language;
    }
    throw ArgumentError.value(initialValue, 'initialValue',
        'Not an ISO code of the languages of this picker');
  }

  /// Resolves the language to select after this widget is updated.
  ///
  /// Only called from [State.didUpdateWidget]. It never throws, because an
  /// exception while the element tree updates takes the whole subtree down.
  Language _reresolveSelection({required bool honourInitialValue}) {
    final Language? controllerValue = widget.controller?.value;
    if (controllerValue != null && _languages.contains(controllerValue)) {
      return controllerValue;
    }
    if (honourInitialValue && widget.initialValue != null) {
      for (final Language language in _languages) {
        if (language.isoCode == widget.initialValue) return language;
      }
    }
    // Keep what the user picked, as long as it survived the list change.
    if (_languages.contains(_selectedLanguage)) return _selectedLanguage;
    return _languages.first;
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<Language>> items = _languages
        .map((Language language) => DropdownMenuItem<Language>(
            value: language,
            child: widget.itemBuilder != null
                ? widget.itemBuilder!(language)
                : _buildDefaultMenuItem(language)))
        .toList();

    return Row(
      children: <Widget>[
        DropdownButtonHideUnderline(
          child: DropdownButton<Language>(
            isDense: true,
            onChanged: (Language? value) {
              if (value == null) return;
              setState(() => _selectedLanguage = value);
              widget.controller?.value = value;
              widget.onValuePicked?.call(value);
            },
            value: _selectedLanguage,
            items: items,
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultMenuItem(Language language) {
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 8.0,
        ),
        Text("${language.name} (${language.isoCode})"),
      ],
    );
  }
}
