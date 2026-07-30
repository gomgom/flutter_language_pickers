import 'package:flutter/foundation.dart' show listEquals;
import 'package:language_pickers/languages.dart';
import 'package:language_pickers/utils/typedefs.dart';

import 'package:language_pickers/utils/my_alert_dialog.dart';
import 'package:flutter/material.dart';

///Provides a customizable [Dialog] which displays all languages
/// with optional search feature

class LanguagePickerDialog extends StatefulWidget {
  /// Callback that is called with selected Language
  final ValueChanged<Language>? onValuePicked;

  /// The (optional) title of the dialog is displayed in a large font at the top
  /// of the dialog.
  ///
  /// Typically a [Text] widget.
  final Widget? title;

  /// Padding around the title.
  ///
  /// If there is no title, no padding will be provided. Otherwise, this padding
  /// is used.
  ///
  /// This property defaults to providing 12 pixels on the top,
  /// 16 pixels on bottom of the title. If the [content] is not null, then no bottom padding is
  /// provided (but see [contentPadding]). If it _is_ null, then an extra 20
  /// pixels of bottom padding is added to separate the [title] from the
  /// [actions].
  final EdgeInsetsGeometry? titlePadding;

  /// Padding around the content.

  final EdgeInsetsGeometry contentPadding;

  /// The semantic label of the dialog used by accessibility frameworks to
  /// announce screen transitions when the dialog is opened and closed.
  ///
  /// If this label is not provided, a semantic label will be infered from the
  /// [title] if it is not null.  If there is no title, the label will be taken
  /// from [MaterialLocalizations.alertDialogLabel].
  ///
  /// See also:
  ///
  ///  * [SemanticsConfiguration.isRouteName], for a description of how this
  ///    value is used.
  final String? semanticLabel;

  ///Callback that is called with selected item of type Language which returns a
  ///Widget to build list view item inside dialog
  final ItemBuilder? itemBuilder;

  /// The (optional) horizontal separator used between title, content and
  /// actions.
  ///
  /// If this divider is not provided a [Divider] is used with [height]
  /// property is set to 0.0
  final Widget divider;

  /// The [divider] is not displayed if set to false. Default is set to true.
  final bool isDividerEnabled;

  /// Determines if search [TextField] is shown or not
  /// Defaults to false
  final bool isSearchable;

  /// The optional [decoration] of search [TextField]
  final InputDecoration? searchInputDecoration;

  ///The optional [cursorColor] of search [TextField]
  final Color? searchCursorColor;

  ///The search empty view is displayed if nothing returns from search result
  final Widget? searchEmptyView;

  /// List of languages available in this picker.
  ///
  /// Defaults to [Languages.defaultLanguages]. Treat the list you pass as
  /// immutable: changing it in place does not rebuild the picker, while
  /// passing a different list does.
  final List<Language>? languages;

  /// List of languages available in this picker, as maps.
  @Deprecated('Use languages instead. Will be removed in 0.5.0.')
  final List<Map<String, String>>? languagesList;

  /// Creates a dialog of languages.
  const LanguagePickerDialog({
    super.key,
    this.onValuePicked,
    this.title,
    this.titlePadding,
    this.contentPadding = const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0),
    this.semanticLabel,
    this.itemBuilder,
    this.isDividerEnabled = false,
    this.divider = const Divider(
      height: 0.0,
    ),
    this.isSearchable = false,
    this.searchInputDecoration,
    this.searchCursorColor,
    this.searchEmptyView,
    this.languages,
    @Deprecated('Use languages instead. Will be removed in 0.5.0.')
    this.languagesList,
  }) : assert(languages == null || languagesList == null,
            'Use either languages or the deprecated languagesList, not both.');

  @override
  SingleChoiceDialogState createState() {
    return SingleChoiceDialogState();
  }
}

class SingleChoiceDialogState extends State<LanguagePickerDialog> {
  late List<Language> _allLanguages;
  late List<Language> _filteredLanguages;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _allLanguages = _resolveLanguages();
    _filteredLanguages = _allLanguages;
  }

  @override
  void didUpdateWidget(LanguagePickerDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
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
      _allLanguages = _resolveLanguages();
      // Keep whatever the user has typed so far.
      _filteredLanguages = _filter(_query);
    }
  }

  List<Language> _resolveLanguages() {
    final List<Language>? languages = widget.languages;
    if (languages != null) return languages;
    // ignore: deprecated_member_use_from_same_package
    final List<Map<String, String>>? legacy = widget.languagesList;
    if (legacy != null) return legacy.map(Language.fromMap).toList();
    return Languages.defaultLanguages;
  }

  /// The languages matching [query] by name, native name or ISO 639-1 code.
  List<Language> _filter(String query) {
    if (query.isEmpty) return _allLanguages;
    final String lower = query.toLowerCase();
    return _allLanguages
        .where((Language language) =>
            language.name.toLowerCase().contains(lower) ||
            language.nativeName.toLowerCase().contains(lower) ||
            language.isoCode.toLowerCase().contains(lower))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return MyAlertDialog(
      title: _buildHeader(),
      contentPadding: widget.contentPadding,
      semanticLabel: widget.semanticLabel,
      content: _buildContent(context),
      isDividerEnabled: widget.isDividerEnabled,
      divider: widget.divider,
    );
  }

  Widget _buildContent(BuildContext context) {
    return _filteredLanguages.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            children: _filteredLanguages
                .map((Language item) => SimpleDialogOption(
                      onPressed: () {
                        widget.onValuePicked?.call(item);
                        Navigator.pop(context);
                      },
                      child: widget.itemBuilder != null
                          ? widget.itemBuilder!(item)
                          : Text(item.name),
                    ))
                .toList(),
          )
        : widget.searchEmptyView ??
            const Center(
              child: Text('No language found.'),
            );
  }

  Widget? _buildHeader() {
    final Widget? title = _buildTitle();
    return widget.isSearchable
        ? Column(
            children: <Widget>[
              if (title != null) title,
              _buildSearchField(),
            ],
          )
        : title;
  }

  Widget? _buildTitle() {
    return widget.titlePadding != null
        ? Padding(
            padding: widget.titlePadding!,
            child: widget.title,
          )
        : widget.title;
  }

  Widget _buildSearchField() {
    return TextField(
      cursorColor: widget.searchCursorColor,
      decoration: widget.searchInputDecoration ??
          const InputDecoration(hintText: 'Search'),
      onChanged: (String value) {
        setState(() {
          _query = value;
          _filteredLanguages = _filter(value);
        });
      },
    );
  }
}
