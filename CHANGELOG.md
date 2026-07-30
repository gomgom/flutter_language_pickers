## [0.4.0] - 30th July, 2026

### Added

- `Language.nativeName`: the name written in the language itself. e.g. 'ko' → '한국어'.
- `Languages.defaultLanguages`: a type-safe `List<Language>` replacing the map-based list.
  Every language is also a `const` field of its own, e.g. `Languages.korean`.
- `Language.fromIsoCode(isoCode)` to find a language by its ISO 639-1 code.
- `LanguagePickerDropdownController` to read and change the selection from outside.
- Every picker takes `languages` (`List<Language>`) now.
- Dialog search matches `nativeName` too, so '한국' finds Korean.

### Fixed

- `Language` implements `==` and `hashCode` now. It can be used as a Set/Map key,
  and the dropdown no longer crashes when an equal but newly built `Language` is given.
- 'nb' is named 'Norwegian Bokmål' now. It used to show as 'Norwegian', the same
  as 'no', so the picker had two identical looking items.
- The pickers follow changes of `initialValue`, `controller` and `languages`
  after they are built. Rebuilding a parent with an equal but new list no longer
  throws away what the user picked.
- `LanguagePickerDropdown` removes its controller listener when it is disposed.
- Fixed all static analysis issues.

### Changed

- `Language.fromIsoCode` and `LanguagePickerDropdown` throw an `ArgumentError` now.
  0.3.0 threw an `Exception`, so code catching it with `on Exception` no longer
  catches it. `ArgumentError` is an `Error`, not an `Exception`.
- The published package no longer contains the leftover app scaffolding
  (`android/`, `ios/`) or the tests.

### Deprecated (will be removed in 0.5.0)

- `defaultLanguagesList` → use `Languages.defaultLanguages`
- `languagesList` parameter → use `languages`
- `LanguagePickerUtils.getLanguageByIsoCode` → use `Language.fromIsoCode`

Native names are based on the public ISO 639-1 code table.


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
