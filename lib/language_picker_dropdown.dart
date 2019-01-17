import 'package:language_pickers/language.dart';
import 'package:language_pickers/languages.dart';
import 'package:language_pickers/utils/typedefs.dart';
import 'package:flutter/material.dart';
import 'utils/utils.dart';

///Provides a customizable [DropdownButton] for all languages
class LanguagePickerDropdown extends StatefulWidget {
  LanguagePickerDropdown(
      {this.itemBuilder, this.initialValue, this.onValuePicked});

  ///This function will be called to build the child of DropdownMenuItem
  ///If it is not provided, default one will be used which displays
  ///flag image, isoCode and phoneCode in a row.
  ///Check _buildDefaultMenuItem method for details.
  final ItemBuilder itemBuilder;

  ///It should be one of the ISO ALPHA-2 Code that is provided
  ///in languagesList map of languages.dart file.
  final String initialValue;

  ///This function will be called whenever a Language item is selected.
  final ValueChanged<Language> onValuePicked;

  @override
  _LanguagePickerDropdownState createState() => _LanguagePickerDropdownState();
}

class _LanguagePickerDropdownState extends State<LanguagePickerDropdown> {
  List<Language> _languages;
  Language _selectedLanguage;

  @override
  void initState() {
    _languages = languagesList.map((item) => Language.fromMap(item)).toList();
    if (widget.initialValue != null) {
      try {
        _selectedLanguage = _languages
            .where((language) =>
                language.isoCode == widget.initialValue.toLowerCase())
            .toList()[0];
      } catch (error) {
        throw Exception(
            "The initialValue provided is not a supported iso code!");
      }
    } else {
      _selectedLanguage = _languages[0];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<Language>> items = _languages
        .map((language) => DropdownMenuItem<Language>(
            value: language,
            child: widget.itemBuilder != null
                ? widget.itemBuilder(language)
                : _buildDefaultMenuItem(language)))
        .toList();

    return Row(
      children: <Widget>[
        DropdownButtonHideUnderline(
          child: DropdownButton<Language>(
            isDense: true,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value;
                widget.onValuePicked(value);
              });
            },
            items: items,
            value: _selectedLanguage,
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultMenuItem(Language language) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 8.0,
        ),
        Text("${language.name} (${language.isoCode})"),
      ],
    );
  }
}
