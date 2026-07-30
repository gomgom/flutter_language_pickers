import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import 'package:language_pickers/language_pickers.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'language_pickers Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'language_pickers Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // The controller lets you read and change the dropdown selection from
  // anywhere, not only from inside onValuePicked.
  final LanguagePickerDropdownController _dropdownController =
      LanguagePickerDropdownController(initialValue: Languages.korean);

  Language _selectedDialogLanguage = Language.fromIsoCode('ko');
  Language _selectedCupertinoLanguage = Language.fromIsoCode('ko');

  @override
  void dispose() {
    _dropdownController.dispose();
    super.dispose();
  }

  // It's sample code of Dropdown Item. It shows the native name too, so that
  // people find their own language without reading English.
  Widget _buildDropdownItem(Language language) {
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 8.0,
        ),
        Text("${language.name} (${language.nativeName})"),
      ],
    );
  }

  // It's sample code of Dialog Item.
  Widget _buildDialogItem(Language language) => Row(
        children: <Widget>[
          Text(language.name),
          const SizedBox(width: 8.0),
          Flexible(child: Text("(${language.isoCode})"))
        ],
      );

  void _openLanguagePickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: LanguagePickerDialog(
                titlePadding: const EdgeInsets.all(8.0),
                searchCursorColor: Colors.pinkAccent,
                searchInputDecoration:
                    const InputDecoration(hintText: 'Search...'),
                isSearchable: true,
                title: const Text('Select your language'),
                onValuePicked: (Language language) => setState(() {
                      _selectedDialogLanguage = language;
                      debugPrint(_selectedDialogLanguage.name);
                      debugPrint(_selectedDialogLanguage.isoCode);
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
            debugPrint(_selectedCupertinoLanguage.name);
            debugPrint(_selectedCupertinoLanguage.isoCode);
          }),
        );
      });

  Widget _buildCupertinoItem(Language language) => Row(
        children: <Widget>[
          Text("+${language.name}"),
          const SizedBox(width: 8.0),
          Flexible(child: Text(language.nativeName))
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      LanguagePickerDropdown(
                        controller: _dropdownController,
                        itemBuilder: _buildDropdownItem,
                        onValuePicked: (Language language) {
                          debugPrint(language.name);
                          debugPrint(language.isoCode);
                        },
                      ),
                      // Changing the controller moves the dropdown above.
                      TextButton(
                        onPressed: () =>
                            _dropdownController.selectIsoCode('ja'),
                        child: const Text('Set the dropdown to Japanese'),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: MaterialButton(
                    onPressed: _openLanguagePickerDialog,
                    child: Text("Push (${_selectedDialogLanguage.nativeName})"),
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
