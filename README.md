# language_pickers

![](https://img.shields.io/github/license/gomgomize/flutter_language_pickers.svg)
![](https://img.shields.io/badge/Flutter%20Package-^0.1.2-blue.svg)
![](https://img.shields.io/github/languages/code-size/gomgomize/flutter_language_pickers.svg)

It's [package](https://flutter.io/developing-packages/) for Dart and Flutter.

It makes language select pickers for you in Flutter. You can use it freely in lots of ways.

And specially thanks to Figen Güngör([@figengungor](https://github.com/figengungor)), who is opened the source code of '[country_pickers](https://pub.dartlang.org/packages/country_pickers)'.
Lots of source codes are from [country_pickers GitHub Repository](https://github.com/figengungor/country_pickers), so works are very easy. Thanks again.

![](art/example.gif)

## Getting Started

#### LanguagePickerDropdown example

```dart
import 'package:language_pickers/language.dart';
import 'package:language_pickers/language_pickers.dart';

Language _selectedDropdownLanguage =
      LanguagePickerUtils.getLanguageByIsoCode('ko');

// It's sample code of Dropdown Item.
Widget _buildDropdownItem(Language language) {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 8.0,
      ),
      Text("${language.name} (${language.isoCode})"),
    ],
  );
}


// Builder
LanguagePickerDropdown(
                    initialValue: 'ko',
                    itemBuilder: _buildDropdownItem,
                    onValuePicked: (Language language) {
                      _selectedDropdownLanguage = language;
                      print(_selectedDropdownLanguage.name);
                      print(_selectedDropdownLanguage.isoCode);
                    },
                  ),
```

#### LanguagePickerDialog example

```dart
import 'package:language_pickers/language.dart';
import 'package:language_pickers/language_pickers.dart';

Language _selectedDialogLanguage =
      LanguagePickerUtils.getLanguageByIsoCode('ko');

// It's sample code of Dialog Item.
Widget _buildDialogItem(Language language) => Row(
    children: <Widget>[
      Text(language.name),
      SizedBox(width: 8.0),
      Flexible(child: Text("(${language.isoCode})"))
    ],
  );

void _openLanguagePickerDialog() => showDialog(
    context: context,
    builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.pink),
        child: LanguagePickerDialog(
            titlePadding: EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: Text('Select your language'),
            onValuePicked: (Language language) => setState(() {
                  _selectedDialogLanguage = language;
                  print(_selectedDialogLanguage.name);
                  print(_selectedDialogLanguage.isoCode);
                }),
            itemBuilder: _buildDialogItem)),
  );
```

#### LanguagePickerCupertino example

```dart
import 'package:language_pickers/language.dart';
import 'package:language_pickers/language_pickers.dart';

Language _selectedCupertinoLanguage =
  LanguagePickerUtils.getLanguageByIsoCode('ko');

// It's sample code of Cupertino Item.
void _openCupertinoLanguagePicker() => showCupertinoModalPopup<void>(
  context: context,
  builder: (BuildContext context) {
    return LanguagePickerCupertino(
      pickerSheetHeight: 200.0,
      onValuePicked: (Language language) => setState(() {
            _selectedCupertinoLanguage = language;
            print(_selectedCupertinoLanguage.name);
            print(_selectedCupertinoLanguage.isoCode);
          }),
    );
  });

Widget _buildCupertinoItem(Language language) => Row(
    children: <Widget>[
      Text("+${language.name}"),
      SizedBox(width: 8.0),
      Flexible(child: Text(language.name))
    ],
  );
```


## Information

**If you want to change your language name to your native language, not English, please make some issues on [Github](https://github.com/gomgomize/flutter_language_pickers/issues).**


## Credits

Developed by [Gomgom](https://www.gomgom.io)(Github [@gomgomize](https://github.com/gomgomize)).