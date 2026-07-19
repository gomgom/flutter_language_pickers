## [0.3.0] - 19th July, 2026

- Support null safety and Dart 3, so it works with latest Flutter again. (Thanks to spsarolkar's Pull Request)
- (Pull Request Merge -- crtl) Remove duplicated 'English' option which has wrong iso code 'alpha2'.
- Now language_pickers.dart exports languages.dart too, so you need only one import.
- Cupertino picker follows iOS dark mode now, and its options(backgroundColor, diameterRatio, scrollController, etc.) really work now.
- (Issue -- dizang2) Search finds any part of language name now, not only the beginning.
- Fix crash when dialog is searchable but has no title.
- Update example app to new Android embedding.


## [0.2.0+1] - 3rd March, 2020

- Fix type bugs for other widgets.
- Remove author sector in pubspec.yaml


## [0.2.0] - 1st March, 2020

- Bug fixes.
- Change languages type.


## [0.1.3] - 9th October, 2019

- (Pull Request Merge -- Masato Nagashima) Renamed from country to language.
- (Pull Request Merge -- Masato Nagashima) Enabled a user of this picker to choose his/her own language list.
- (Pull Request Merge -- Masato Nagashima) Changed from native writing systems to English.


## [0.1.2] - 11th February, 2019

- Fix README.md.


## [0.1.1] - 19th January, 2019

- Fix error 'Error: unable to find directory entry in pubspec.yaml'.


## [0.1.0] - 17th January, 2019

- First release of package(language_pickers).
