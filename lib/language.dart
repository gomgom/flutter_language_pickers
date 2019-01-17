class Language {
  Language(this.isoCode, this.name);

  final String name;
  final String isoCode;

  Language.fromMap(Map<String, String> map)
      : name = map['name'],
        isoCode = map['isoCode'];
}
