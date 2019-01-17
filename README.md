# language_pickers

It's [package](https://flutter.io/developing-packages/) for Dart and Flutter.

It makes language select pickers for you in Flutter. You can use it freely in lots of ways.

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

**If do you want to change your language to your native language, not English, please make some issues on [Github](https://github.com/devbygomgom/flutter_language_pickers/issues).**


## Credits

Copyright 2019 [gomgom](https://www.gomgom.io)(Github [@devbygomgom](https://github.com/devbygomgom)). ON BSD LICENSE.

And specially thanks to Figen Güngör([@figengungor](https://github.com/figengungor)), who is opened the source code of 'country_pickers(Flutter library)'.

I used his code, so works are very easy. Thanks again.


## License

Copyright 2019 gomgom.
Lots of source codes are from country_pickers, specially thanks to 'Copyright 2018 Figen Güngör'.

Redistribution and use in source and binary forms, with or without modification, are permitted
provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions
and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of
conditions and the following disclaimer in the documentation and/or other materials provided
with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
