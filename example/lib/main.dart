import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import 'package:language_pickers/languages.dart';
import 'package:language_pickers/language_pickers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'language_pickers Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'language_pickers Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Language _selectedDropdownLanguage =
      LanguagePickerUtils.getLanguageByIsoCode('ko');
  Language _selectedDialogLanguage =
      LanguagePickerUtils.getLanguageByIsoCode('ko');
  Language _selectedCupertinoLanguage =
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: LanguagePickerDropdown(
                    initialValue: 'ko',
                    itemBuilder: _buildDropdownItem,
                    onValuePicked: (Language language) {
                      _selectedDropdownLanguage = language;
                      print(_selectedDropdownLanguage.name);
                      print(_selectedDropdownLanguage.isoCode);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: MaterialButton(
                    child: Text("Push"),
                    onPressed: _openLanguagePickerDialog,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: ListTile(
                    title: _buildCupertinoItem(_selectedCupertinoLanguage),
                    onTap: _openCupertinoLanguagePicker,
                  ),
                ),
              ),
            ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
