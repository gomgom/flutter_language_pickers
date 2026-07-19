import 'package:language_pickers/languages.dart';
import 'package:language_pickers/utils/typedefs.dart';
import 'package:flutter/cupertino.dart';

const double defaultPickerSheetHeight = 216.0;
const double defaultPickerItemHeight = 32.0;

///Provides a customizable [CupertinoPicker] which displays all languages
/// in cupertino style
class LanguagePickerCupertino extends StatefulWidget {
  /// Callback that is called with selected Language
  final ValueChanged<Language>? onValuePicked;

  ///Callback that is called with selected item of type Language which returns a
  ///Widget to build list view item inside dialog
  final ItemBuilder? itemBuilder;

  ///The [itemExtent] of [CupertinoPicker]
  /// The uniform height of all children.
  ///
  /// All children will be given the [BoxConstraints] to match this exact
  /// height. Must not be null and must be positive.
  final double pickerItemHeight;

  ///The height of the picker
  final double pickerSheetHeight;

  ///The TextStyle that is applied to Text widgets inside item
  final TextStyle? textStyle;

  /// Relative ratio between this picker's height and the simulated cylinder's diameter.
  ///
  /// Smaller values creates more pronounced curvatures in the scrollable wheel.
  ///
  /// For more details, see [ListWheelScrollView.diameterRatio].
  ///
  /// Defaults to `1.07` to visually mimic iOS.
  final double? diameterRatio;

  /// Background color behind the children.
  ///
  /// Defaults to [CupertinoColors.systemBackground], so it follows
  /// light and dark mode of the device.
  final Color? backgroundColor;

  /// {@macro flutter.rendering.wheelList.offAxisFraction}
  final double? offAxisFraction;

  /// {@macro flutter.rendering.wheelList.useMagnifier}
  final bool? useMagnifier;

  /// {@macro flutter.rendering.wheelList.magnification}
  final double? magnification;

  /// A [FixedExtentScrollController] to read and control the current item.
  ///
  /// If null, an implicit one will be created internally.
  final FixedExtentScrollController? scrollController;

  /// List of languages available in this picker.
  final List<Map<String, String>>? languagesList;

  const LanguagePickerCupertino({
    Key? key,
    this.onValuePicked,
    this.itemBuilder,
    this.pickerItemHeight = defaultPickerItemHeight,
    this.pickerSheetHeight = defaultPickerSheetHeight,
    this.textStyle,
    this.diameterRatio,
    this.backgroundColor,
    this.offAxisFraction,
    this.useMagnifier,
    this.magnification,
    this.scrollController,
    this.languagesList,
  }) : super(key: key);

  @override
  _CupertinoLanguagePickerState createState() => _CupertinoLanguagePickerState();
}

class _CupertinoLanguagePickerState extends State<LanguagePickerCupertino> {
  late List<Language> _allLanguages;

  @override
  void initState() {
    super.initState();
    final languageList = widget.languagesList ?? defaultLanguagesList;
    _allLanguages = languageList.map((item) => Language.fromMap(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBottomPicker(_buildPicker());
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: widget.pickerSheetHeight,
      color: CupertinoDynamicColor.resolve(
          widget.backgroundColor ?? CupertinoColors.systemBackground, context),
      child: DefaultTextStyle(
        style: widget.textStyle ??
            TextStyle(
              color: CupertinoDynamicColor.resolve(
                  CupertinoColors.label, context),
              fontSize: 16.0,
            ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            child: picker,
          ),
        ),
      ),
    );
  }

  Widget _buildPicker() {
    return CupertinoPicker(
      scrollController: widget.scrollController,
      itemExtent: widget.pickerItemHeight,
      diameterRatio: widget.diameterRatio ?? 1.07,
      offAxisFraction: widget.offAxisFraction ?? 0.0,
      useMagnifier: widget.useMagnifier ?? false,
      magnification: widget.magnification ?? 1.0,
      backgroundColor:
          widget.backgroundColor ?? CupertinoColors.systemBackground,
      children: _allLanguages
          .map<Widget>((Language language) => widget.itemBuilder != null
              ? widget.itemBuilder!(language)
              : _buildDefaultItem(language))
          .toList(),
      onSelectedItemChanged: (int index) {
        widget.onValuePicked?.call(_allLanguages[index]);
      },
    );
  }

  _buildDefaultItem(Language language) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 8.0),
          Flexible(child: Text(language.name))
        ],
      ),
    );
  }
}
