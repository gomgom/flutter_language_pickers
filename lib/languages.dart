/// A language with its ISO 639-1 code, English name and native name.
///
/// The built-in languages are available as `static const` fields of
/// [Languages], and all of them as [Languages.defaultLanguages].
class Language {
  /// Creates a language.
  ///
  /// [nativeName] falls back to [name] when it is omitted, so code written
  /// against older versions of this package keeps working.
  const Language(this.isoCode, this.name, [String? nativeName])
      : nativeName = nativeName ?? name;

  /// Creates a [Language] from a map.
  ///
  /// 'isoCode' and 'name' are required. 'nativeName' is optional and falls
  /// back to 'name'.
  Language.fromMap(Map<String, String> map)
      : isoCode = map['isoCode']!,
        name = map['name']!,
        nativeName = map['nativeName'] ?? map['name']!;

  /// Finds a language in [Languages.defaultLanguages] by its ISO 639-1 code.
  ///
  /// The lookup ignores case, so 'ko' and 'KO' both find Korean.
  ///
  /// Throws an [ArgumentError] if there is no such language. Note that
  /// [ArgumentError] is an [Error], not an [Exception].
  factory Language.fromIsoCode(String isoCode) {
    final String lower = isoCode.toLowerCase();
    for (final Language language in Languages.defaultLanguages) {
      if (language.isoCode.toLowerCase() == lower) return language;
    }
    throw ArgumentError.value(isoCode, 'isoCode', 'Not a supported ISO code');
  }

  /// ISO 639-1 code. e.g. 'ko'
  final String isoCode;

  /// English name. e.g. 'Korean'
  final String name;

  /// Name written in the language itself. e.g. '한국어'
  ///
  /// It falls back to [name] when it is not known.
  final String nativeName;

  /// Whether [other] is a language with the same [isoCode] and [name].
  ///
  /// [nativeName] is deliberately left out, so a [Language] built from a map
  /// without a native name still equals the built-in one.
  @override
  bool operator ==(Object other) =>
      other is Language && isoCode == other.isoCode && name == other.name;

  @override
  int get hashCode => Object.hash(isoCode, name);

  @override
  String toString() => 'Language($isoCode, $name)';
}

/// The languages built into this package.
///
/// Every language is a `static const` field, and [defaultLanguages] holds all
/// of them. Pass a sublist of it to a picker to narrow the choices down:
///
/// ```dart
/// LanguagePickerDropdown(
///   languages: const <Language>[Languages.korean, Languages.english],
/// )
/// ```
///
/// The names are based on the public ISO 639-1 code table.
class Languages {
  const Languages._();

  /// Abkhazian (ab), Аҧсуа.
  static const Language abkhazian = Language('ab', 'Abkhazian', 'Аҧсуа');

  /// Afar (aa), Afaraf.
  static const Language afar = Language('aa', 'Afar', 'Afaraf');

  /// Afrikaans (af), Afrikaans.
  static const Language afrikaans = Language('af', 'Afrikaans', 'Afrikaans');

  /// Akan (ak), Akan.
  static const Language akan = Language('ak', 'Akan', 'Akan');

  /// Albanian (sq), Shqip.
  static const Language albanian = Language('sq', 'Albanian', 'Shqip');

  /// Amharic (am), አማርኛ.
  static const Language amharic = Language('am', 'Amharic', 'አማርኛ');

  /// Arabic (ar), العربية.
  static const Language arabic = Language('ar', 'Arabic', 'العربية');

  /// Aragonese (an), Aragonés.
  static const Language aragonese = Language('an', 'Aragonese', 'Aragonés');

  /// Armenian (hy), Հայերեն.
  static const Language armenian = Language('hy', 'Armenian', 'Հայերեն');

  /// Assamese (as), অসমীয়া.
  static const Language assamese = Language('as', 'Assamese', 'অসমীয়া');

  /// Avaric (av), Авар мацӀ.
  static const Language avaric = Language('av', 'Avaric', 'Авар мацӀ');

  /// Avestan (ae), Avesta.
  static const Language avestan = Language('ae', 'Avestan', 'Avesta');

  /// Aymara (ay), Aymar aru.
  static const Language aymara = Language('ay', 'Aymara', 'Aymar aru');

  /// Azerbaijani (az), Azərbaycan dili.
  static const Language azerbaijani =
      Language('az', 'Azerbaijani', 'Azərbaycan dili');

  /// Bambara (bm), Bamanankan.
  static const Language bambara = Language('bm', 'Bambara', 'Bamanankan');

  /// Bashkir (ba), башҡорт теле.
  static const Language bashkir = Language('ba', 'Bashkir', 'башҡорт теле');

  /// Basque (eu), Euskara.
  static const Language basque = Language('eu', 'Basque', 'Euskara');

  /// Belarusian (be), Беларуская.
  static const Language belarusian = Language('be', 'Belarusian', 'Беларуская');

  /// Bengali (bn), বাংলা.
  static const Language bengali = Language('bn', 'Bengali', 'বাংলা');

  /// Bihari Languages (bh), भोजपुरी.
  static const Language bihariLanguages =
      Language('bh', 'Bihari Languages', 'भोजपुरी');

  /// Bislama (bi), Bislama.
  static const Language bislama = Language('bi', 'Bislama', 'Bislama');

  /// Norwegian Bokmål (nb), Norsk bokmål.
  static const Language norwegianBokmal =
      Language('nb', 'Norwegian Bokmål', 'Norsk bokmål');

  /// Bosnian (bs), Bosanski jezik.
  static const Language bosnian = Language('bs', 'Bosnian', 'Bosanski jezik');

  /// Breton (br), Brezhoneg.
  static const Language breton = Language('br', 'Breton', 'Brezhoneg');

  /// Bulgarian (bg), български език.
  static const Language bulgarian =
      Language('bg', 'Bulgarian', 'български език');

  /// Burmese (my), ဗမာစာ.
  static const Language burmese = Language('my', 'Burmese', 'ဗမာစာ');

  /// Catalan (ca), Català.
  static const Language catalan = Language('ca', 'Catalan', 'Català');

  /// Central Khmer (km), ភាសាខ្មែរ.
  static const Language centralKhmer =
      Language('km', 'Central Khmer', 'ភាសាខ្មែរ');

  /// Chamorro (ch), Chamoru.
  static const Language chamorro = Language('ch', 'Chamorro', 'Chamoru');

  /// Chechen (ce), нохчийн мотт.
  static const Language chechen = Language('ce', 'Chechen', 'нохчийн мотт');

  /// Chewa (Nyanja) (ny), chiCheŵa.
  static const Language chewaNyanja =
      Language('ny', 'Chewa (Nyanja)', 'chiCheŵa');

  /// Chinese (Simplified) (zh_Hans), 简体中文.
  static const Language chineseSimplified =
      Language('zh_Hans', 'Chinese (Simplified)', '简体中文');

  /// Chinese (Traditional) (zh_Hant), 繁體中文.
  static const Language chineseTraditional =
      Language('zh_Hant', 'Chinese (Traditional)', '繁體中文');

  /// Church Slavonic (cu), ѩзыкъ словѣньскъ.
  static const Language churchSlavonic =
      Language('cu', 'Church Slavonic', 'ѩзыкъ словѣньскъ');

  /// Chuvash (cv), чӑваш чӗлхи.
  static const Language chuvash = Language('cv', 'Chuvash', 'чӑваш чӗлхи');

  /// Cornish (kw), Kernewek.
  static const Language cornish = Language('kw', 'Cornish', 'Kernewek');

  /// Corsican (co), Corsu.
  static const Language corsican = Language('co', 'Corsican', 'Corsu');

  /// Cree (cr), ᓀᐦᐃᔭᐍᐏᐣ.
  static const Language cree = Language('cr', 'Cree', 'ᓀᐦᐃᔭᐍᐏᐣ');

  /// Croatian (hr), Hrvatski.
  static const Language croatian = Language('hr', 'Croatian', 'Hrvatski');

  /// Czech (cs), Čeština.
  static const Language czech = Language('cs', 'Czech', 'Čeština');

  /// Danish (da), Dansk.
  static const Language danish = Language('da', 'Danish', 'Dansk');

  /// Dhivehi (dv), ދިވެހި.
  static const Language dhivehi = Language('dv', 'Dhivehi', 'ދިވެހި');

  /// Dutch (nl), Nederlands.
  static const Language dutch = Language('nl', 'Dutch', 'Nederlands');

  /// Dzongkha (dz), རྫོང་ཁ.
  static const Language dzongkha = Language('dz', 'Dzongkha', 'རྫོང་ཁ');

  /// English (en), English.
  static const Language english = Language('en', 'English', 'English');

  /// Esperanto (eo), Esperanto.
  static const Language esperanto = Language('eo', 'Esperanto', 'Esperanto');

  /// Estonian (et), Eesti.
  static const Language estonian = Language('et', 'Estonian', 'Eesti');

  /// Ewe (ee), Eʋegbe.
  static const Language ewe = Language('ee', 'Ewe', 'Eʋegbe');

  /// Faroese (fo), Føroyskt.
  static const Language faroese = Language('fo', 'Faroese', 'Føroyskt');

  /// Fijian (fj), Vosa Vakaviti.
  static const Language fijian = Language('fj', 'Fijian', 'Vosa Vakaviti');

  /// Finnish (fi), Suomi.
  static const Language finnish = Language('fi', 'Finnish', 'Suomi');

  /// French (fr), Français.
  static const Language french = Language('fr', 'French', 'Français');

  /// Fulah (ff), Fulfulde.
  static const Language fulah = Language('ff', 'Fulah', 'Fulfulde');

  /// Gaelic (gd), Gàidhlig.
  static const Language gaelic = Language('gd', 'Gaelic', 'Gàidhlig');

  /// Galician (gl), Galego.
  static const Language galician = Language('gl', 'Galician', 'Galego');

  /// Ganda (lg), Luganda.
  static const Language ganda = Language('lg', 'Ganda', 'Luganda');

  /// Georgian (ka), ქართული.
  static const Language georgian = Language('ka', 'Georgian', 'ქართული');

  /// German (de), Deutsch.
  static const Language german = Language('de', 'German', 'Deutsch');

  /// Greek, Modern (1453-) (el), Ελληνικά.
  static const Language greek =
      Language('el', 'Greek, Modern (1453-)', 'Ελληνικά');

  /// Guarani (gn), Avañeẽ.
  static const Language guarani = Language('gn', 'Guarani', 'Avañeẽ');

  /// Gujarati (gu), ગુજરાતી.
  static const Language gujarati = Language('gu', 'Gujarati', 'ગુજરાતી');

  /// Haitian (ht), Kreyòl ayisyen.
  static const Language haitian = Language('ht', 'Haitian', 'Kreyòl ayisyen');

  /// Hausa (ha), Hausa.
  static const Language hausa = Language('ha', 'Hausa', 'Hausa');

  /// Hebrew (he), עברית.
  static const Language hebrew = Language('he', 'Hebrew', 'עברית');

  /// Herero (hz), Otjiherero.
  static const Language herero = Language('hz', 'Herero', 'Otjiherero');

  /// Hindi (hi), हिन्दी.
  static const Language hindi = Language('hi', 'Hindi', 'हिन्दी');

  /// Hiri Motu (ho), Hiri Motu.
  static const Language hiriMotu = Language('ho', 'Hiri Motu', 'Hiri Motu');

  /// Hungarian (hu), Magyar.
  static const Language hungarian = Language('hu', 'Hungarian', 'Magyar');

  /// Icelandic (is), Íslenska.
  static const Language icelandic = Language('is', 'Icelandic', 'Íslenska');

  /// Ido (io), Ido.
  static const Language ido = Language('io', 'Ido', 'Ido');

  /// Igbo (ig), Asụsụ Igbo.
  static const Language igbo = Language('ig', 'Igbo', 'Asụsụ Igbo');

  /// Indonesian (id), Bahasa Indonesia.
  static const Language indonesian =
      Language('id', 'Indonesian', 'Bahasa Indonesia');

  /// Interlingua (ia), Interlingua.
  static const Language interlingua =
      Language('ia', 'Interlingua', 'Interlingua');

  /// Interlingue (ie), Interlingue.
  static const Language interlingue =
      Language('ie', 'Interlingue', 'Interlingue');

  /// Inuktitut (iu), ᐃᓄᒃᑎᑐᑦ.
  static const Language inuktitut = Language('iu', 'Inuktitut', 'ᐃᓄᒃᑎᑐᑦ');

  /// Inupiaq (ik), Iñupiaq.
  static const Language inupiaq = Language('ik', 'Inupiaq', 'Iñupiaq');

  /// Irish (ga), Gaeilge.
  static const Language irish = Language('ga', 'Irish', 'Gaeilge');

  /// Italian (it), Italiano.
  static const Language italian = Language('it', 'Italian', 'Italiano');

  /// Japanese (ja), 日本語.
  static const Language japanese = Language('ja', 'Japanese', '日本語');

  /// Javanese (jv), Basa Jawa.
  static const Language javanese = Language('jv', 'Javanese', 'Basa Jawa');

  /// Kalaallisut (kl), Kalaallisut.
  static const Language kalaallisut =
      Language('kl', 'Kalaallisut', 'Kalaallisut');

  /// Kannada (kn), ಕನ್ನಡ.
  static const Language kannada = Language('kn', 'Kannada', 'ಕನ್ನಡ');

  /// Kanuri (kr), Kanuri.
  static const Language kanuri = Language('kr', 'Kanuri', 'Kanuri');

  /// Kashmiri (ks), कश्मीरी.
  static const Language kashmiri = Language('ks', 'Kashmiri', 'कश्मीरी');

  /// Kazakh (kk), Қазақ тілі.
  static const Language kazakh = Language('kk', 'Kazakh', 'Қазақ тілі');

  /// Kikuyu (ki), Gĩkũyũ.
  static const Language kikuyu = Language('ki', 'Kikuyu', 'Gĩkũyũ');

  /// Kinyarwanda (rw), Ikinyarwanda.
  static const Language kinyarwanda =
      Language('rw', 'Kinyarwanda', 'Ikinyarwanda');

  /// Kirghiz (ky), Кыргыз тили.
  static const Language kirghiz = Language('ky', 'Kirghiz', 'Кыргыз тили');

  /// Komi (kv), коми кыв.
  static const Language komi = Language('kv', 'Komi', 'коми кыв');

  /// Kongo (kg), KiKongo.
  static const Language kongo = Language('kg', 'Kongo', 'KiKongo');

  /// Korean (ko), 한국어.
  static const Language korean = Language('ko', 'Korean', '한국어');

  /// Kuanyama (kj), Kuanyama.
  static const Language kuanyama = Language('kj', 'Kuanyama', 'Kuanyama');

  /// Kurdish (ku), Kurdî.
  static const Language kurdish = Language('ku', 'Kurdish', 'Kurdî');

  /// Lao (lo), ພາສາລາວ.
  static const Language lao = Language('lo', 'Lao', 'ພາສາລາວ');

  /// Latin (la), Lingua Latina.
  static const Language latin = Language('la', 'Latin', 'Lingua Latina');

  /// Latvian (lv), Latviešu valoda.
  static const Language latvian = Language('lv', 'Latvian', 'Latviešu valoda');

  /// Limburgan (li), Limburgs.
  static const Language limburgan = Language('li', 'Limburgan', 'Limburgs');

  /// Lingala (ln), Lingála.
  static const Language lingala = Language('ln', 'Lingala', 'Lingála');

  /// Lithuanian (lt), Lietuvių kalba.
  static const Language lithuanian =
      Language('lt', 'Lithuanian', 'Lietuvių kalba');

  /// Luba-Katanga (lu), Luba-Katanga.
  static const Language lubaKatanga =
      Language('lu', 'Luba-Katanga', 'Luba-Katanga');

  /// Luxembourgish (lb), Lëtzebuergesch.
  static const Language luxembourgish =
      Language('lb', 'Luxembourgish', 'Lëtzebuergesch');

  /// Macedonian (mk), македонски јазик.
  static const Language macedonian =
      Language('mk', 'Macedonian', 'македонски јазик');

  /// Malagasy (mg), Malagasy fiteny.
  static const Language malagasy =
      Language('mg', 'Malagasy', 'Malagasy fiteny');

  /// Malay (ms), Bahasa Melayu.
  static const Language malay = Language('ms', 'Malay', 'Bahasa Melayu');

  /// Malayalam (ml), മലയാളം.
  static const Language malayalam = Language('ml', 'Malayalam', 'മലയാളം');

  /// Maltese (mt), Malti.
  static const Language maltese = Language('mt', 'Maltese', 'Malti');

  /// Manx (gv), Gaelg.
  static const Language manx = Language('gv', 'Manx', 'Gaelg');

  /// Maori (mi), Te reo Māori.
  static const Language maori = Language('mi', 'Maori', 'Te reo Māori');

  /// Marathi (mr), मराठी.
  static const Language marathi = Language('mr', 'Marathi', 'मराठी');

  /// Marshallese (mh), Kajin M̧ajeļ.
  static const Language marshallese =
      Language('mh', 'Marshallese', 'Kajin M̧ajeļ');

  /// Mongolian (mn), Монгол.
  static const Language mongolian = Language('mn', 'Mongolian', 'Монгол');

  /// Nauru (na), Ekakairũ Naoero.
  static const Language nauru = Language('na', 'Nauru', 'Ekakairũ Naoero');

  /// Navajo (nv), Diné bizaad.
  static const Language navajo = Language('nv', 'Navajo', 'Diné bizaad');

  /// Ndebele, North (nd), IsiNdebele.
  static const Language ndebeleNorth =
      Language('nd', 'Ndebele, North', 'IsiNdebele');

  /// Ndebele, South (nr), IsiNdebele.
  static const Language ndebeleSouth =
      Language('nr', 'Ndebele, South', 'IsiNdebele');

  /// Ndonga (ng), Owambo.
  static const Language ndonga = Language('ng', 'Ndonga', 'Owambo');

  /// Nepali (ne), नेपाली.
  static const Language nepali = Language('ne', 'Nepali', 'नेपाली');

  /// Northern Sami (se), Davvisámegiella.
  static const Language northernSami =
      Language('se', 'Northern Sami', 'Davvisámegiella');

  /// Norwegian (no), Norsk.
  static const Language norwegian = Language('no', 'Norwegian', 'Norsk');

  /// Norwegian Nynorsk (nn), Norsk nynorsk.
  static const Language norwegianNynorsk =
      Language('nn', 'Norwegian Nynorsk', 'Norsk nynorsk');

  /// Occitan (post 1500) (oc), Occitan.
  static const Language occitan =
      Language('oc', 'Occitan (post 1500)', 'Occitan');

  /// Ojibwa (oj), ᐊᓂᔑᓈᐯᒧᐎᓐ.
  static const Language ojibwa = Language('oj', 'Ojibwa', 'ᐊᓂᔑᓈᐯᒧᐎᓐ');

  /// Oriya (or), ଓଡ଼ିଆ.
  static const Language oriya = Language('or', 'Oriya', 'ଓଡ଼ିଆ');

  /// Oromo (om), Afaan Oromoo.
  static const Language oromo = Language('om', 'Oromo', 'Afaan Oromoo');

  /// Ossetian (os), ирон æвзаг.
  static const Language ossetian = Language('os', 'Ossetian', 'ирон æвзаг');

  /// Pali (pi), पाऴि.
  static const Language pali = Language('pi', 'Pali', 'पाऴि');

  /// Panjabi (pa), ਪੰਜਾਬੀ.
  static const Language panjabi = Language('pa', 'Panjabi', 'ਪੰਜਾਬੀ');

  /// Persian (fa), فارسی.
  static const Language persian = Language('fa', 'Persian', 'فارسی');

  /// Polish (pl), Polski.
  static const Language polish = Language('pl', 'Polish', 'Polski');

  /// Portuguese (pt), Português.
  static const Language portuguese = Language('pt', 'Portuguese', 'Português');

  /// Pushto (ps), پښتو.
  static const Language pushto = Language('ps', 'Pushto', 'پښتو');

  /// Quechua (qu), Runa Simi.
  static const Language quechua = Language('qu', 'Quechua', 'Runa Simi');

  /// Romanian (ro), Română.
  static const Language romanian = Language('ro', 'Romanian', 'Română');

  /// Romansh (rm), Rumantsch grischun.
  static const Language romansh =
      Language('rm', 'Romansh', 'Rumantsch grischun');

  /// Rundi (rn), KiRundi.
  static const Language rundi = Language('rn', 'Rundi', 'KiRundi');

  /// Russian (ru), Русский язык.
  static const Language russian = Language('ru', 'Russian', 'Русский язык');

  /// Samoan (sm), Gagana faa Samoa.
  static const Language samoan = Language('sm', 'Samoan', 'Gagana faa Samoa');

  /// Sango (sg), Yângâ tî sängö.
  static const Language sango = Language('sg', 'Sango', 'Yângâ tî sängö');

  /// Sanskrit (sa), संस्कृतम्.
  static const Language sanskrit = Language('sa', 'Sanskrit', 'संस्कृतम्');

  /// Sardinian (sc), Sardu.
  static const Language sardinian = Language('sc', 'Sardinian', 'Sardu');

  /// Serbian (sr), Српски језик.
  static const Language serbian = Language('sr', 'Serbian', 'Српски језик');

  /// Shona (sn), ChiShona.
  static const Language shona = Language('sn', 'Shona', 'ChiShona');

  /// Sichuan Yi (ii), ꆈꌠꉙ.
  static const Language sichuanYi = Language('ii', 'Sichuan Yi', 'ꆈꌠꉙ');

  /// Sindhi (sd), सिन्धी.
  static const Language sindhi = Language('sd', 'Sindhi', 'सिन्धी');

  /// Sinhala (si), සිංහල.
  static const Language sinhala = Language('si', 'Sinhala', 'සිංහල');

  /// Slovak (sk), Slovenčina.
  static const Language slovak = Language('sk', 'Slovak', 'Slovenčina');

  /// Slovenian (sl), Slovenščina.
  static const Language slovenian = Language('sl', 'Slovenian', 'Slovenščina');

  /// Somali (so), Soomaaliga.
  static const Language somali = Language('so', 'Somali', 'Soomaaliga');

  /// Sotho, Southern (st), Sesotho.
  static const Language sothoSouthern =
      Language('st', 'Sotho, Southern', 'Sesotho');

  /// Spanish (es), Español.
  static const Language spanish = Language('es', 'Spanish', 'Español');

  /// Sundanese (su), Basa Sunda.
  static const Language sundanese = Language('su', 'Sundanese', 'Basa Sunda');

  /// Swahili (sw), Kiswahili.
  static const Language swahili = Language('sw', 'Swahili', 'Kiswahili');

  /// Swati (ss), SiSwati.
  static const Language swati = Language('ss', 'Swati', 'SiSwati');

  /// Swedish (sv), Svenska.
  static const Language swedish = Language('sv', 'Swedish', 'Svenska');

  /// Tagalog (tl), Wikang Tagalog.
  static const Language tagalog = Language('tl', 'Tagalog', 'Wikang Tagalog');

  /// Tahitian (ty), Reo Tahiti.
  static const Language tahitian = Language('ty', 'Tahitian', 'Reo Tahiti');

  /// Tajik (tg), тоҷикӣ.
  static const Language tajik = Language('tg', 'Tajik', 'тоҷикӣ');

  /// Tamil (ta), தமிழ்.
  static const Language tamil = Language('ta', 'Tamil', 'தமிழ்');

  /// Tatar (tt), татарча.
  static const Language tatar = Language('tt', 'Tatar', 'татарча');

  /// Telugu (te), తెలుగు.
  static const Language telugu = Language('te', 'Telugu', 'తెలుగు');

  /// Thai (th), ไทย.
  static const Language thai = Language('th', 'Thai', 'ไทย');

  /// Tibetan (bo), བོད་ཡིག.
  static const Language tibetan = Language('bo', 'Tibetan', 'བོད་ཡིག');

  /// Tigrinya (ti), ትግርኛ.
  static const Language tigrinya = Language('ti', 'Tigrinya', 'ትግርኛ');

  /// Tonga (Tonga Islands) (to), Faka Tonga.
  static const Language tonga =
      Language('to', 'Tonga (Tonga Islands)', 'Faka Tonga');

  /// Tsonga (ts), Xitsonga.
  static const Language tsonga = Language('ts', 'Tsonga', 'Xitsonga');

  /// Tswana (tn), Setswana.
  static const Language tswana = Language('tn', 'Tswana', 'Setswana');

  /// Turkish (tr), Türkçe.
  static const Language turkish = Language('tr', 'Turkish', 'Türkçe');

  /// Turkmen (tk), Türkmen.
  static const Language turkmen = Language('tk', 'Turkmen', 'Türkmen');

  /// Twi (tw), Twi.
  static const Language twi = Language('tw', 'Twi', 'Twi');

  /// Uighur (ug), ئۇيغۇرچە.
  static const Language uighur = Language('ug', 'Uighur', 'ئۇيغۇرچە');

  /// Ukrainian (uk), Українська.
  static const Language ukrainian = Language('uk', 'Ukrainian', 'Українська');

  /// Urdu (ur), اردو.
  static const Language urdu = Language('ur', 'Urdu', 'اردو');

  /// Uzbek (uz), Oʻzbek.
  static const Language uzbek = Language('uz', 'Uzbek', 'Oʻzbek');

  /// Venda (ve), Tshivenḓa.
  static const Language venda = Language('ve', 'Venda', 'Tshivenḓa');

  /// Vietnamese (vi), Tiếng Việt.
  static const Language vietnamese = Language('vi', 'Vietnamese', 'Tiếng Việt');

  /// Volapük (vo), Volapük.
  static const Language volapuk = Language('vo', 'Volapük', 'Volapük');

  /// Walloon (wa), Walon.
  static const Language walloon = Language('wa', 'Walloon', 'Walon');

  /// Welsh (cy), Cymraeg.
  static const Language welsh = Language('cy', 'Welsh', 'Cymraeg');

  /// Western Frisian (fy), Frysk.
  static const Language westernFrisian =
      Language('fy', 'Western Frisian', 'Frysk');

  /// Wolof (wo), Wollof.
  static const Language wolof = Language('wo', 'Wolof', 'Wollof');

  /// Xhosa (xh), IsiXhosa.
  static const Language xhosa = Language('xh', 'Xhosa', 'IsiXhosa');

  /// Yiddish (yi), ייִדיש.
  static const Language yiddish = Language('yi', 'Yiddish', 'ייִדיש');

  /// Yoruba (yo), Yorùbá.
  static const Language yoruba = Language('yo', 'Yoruba', 'Yorùbá');

  /// Zhuang (za), Vahcuengh.
  static const Language zhuang = Language('za', 'Zhuang', 'Vahcuengh');

  /// Zulu (zu), isiZulu.
  static const Language zulu = Language('zu', 'Zulu', 'isiZulu');

  /// All languages built into this package, in the order the pickers show
  /// them in.
  static const List<Language> defaultLanguages = <Language>[
    abkhazian,
    afar,
    afrikaans,
    akan,
    albanian,
    amharic,
    arabic,
    aragonese,
    armenian,
    assamese,
    avaric,
    avestan,
    aymara,
    azerbaijani,
    bambara,
    bashkir,
    basque,
    belarusian,
    bengali,
    bihariLanguages,
    bislama,
    norwegianBokmal,
    bosnian,
    breton,
    bulgarian,
    burmese,
    catalan,
    centralKhmer,
    chamorro,
    chechen,
    chewaNyanja,
    chineseSimplified,
    chineseTraditional,
    churchSlavonic,
    chuvash,
    cornish,
    corsican,
    cree,
    croatian,
    czech,
    danish,
    dhivehi,
    dutch,
    dzongkha,
    english,
    esperanto,
    estonian,
    ewe,
    faroese,
    fijian,
    finnish,
    french,
    fulah,
    gaelic,
    galician,
    ganda,
    georgian,
    german,
    greek,
    guarani,
    gujarati,
    haitian,
    hausa,
    hebrew,
    herero,
    hindi,
    hiriMotu,
    hungarian,
    icelandic,
    ido,
    igbo,
    indonesian,
    interlingua,
    interlingue,
    inuktitut,
    inupiaq,
    irish,
    italian,
    japanese,
    javanese,
    kalaallisut,
    kannada,
    kanuri,
    kashmiri,
    kazakh,
    kikuyu,
    kinyarwanda,
    kirghiz,
    komi,
    kongo,
    korean,
    kuanyama,
    kurdish,
    lao,
    latin,
    latvian,
    limburgan,
    lingala,
    lithuanian,
    lubaKatanga,
    luxembourgish,
    macedonian,
    malagasy,
    malay,
    malayalam,
    maltese,
    manx,
    maori,
    marathi,
    marshallese,
    mongolian,
    nauru,
    navajo,
    ndebeleNorth,
    ndebeleSouth,
    ndonga,
    nepali,
    northernSami,
    norwegian,
    norwegianNynorsk,
    occitan,
    ojibwa,
    oriya,
    oromo,
    ossetian,
    pali,
    panjabi,
    persian,
    polish,
    portuguese,
    pushto,
    quechua,
    romanian,
    romansh,
    rundi,
    russian,
    samoan,
    sango,
    sanskrit,
    sardinian,
    serbian,
    shona,
    sichuanYi,
    sindhi,
    sinhala,
    slovak,
    slovenian,
    somali,
    sothoSouthern,
    spanish,
    sundanese,
    swahili,
    swati,
    swedish,
    tagalog,
    tahitian,
    tajik,
    tamil,
    tatar,
    telugu,
    thai,
    tibetan,
    tigrinya,
    tonga,
    tsonga,
    tswana,
    turkish,
    turkmen,
    twi,
    uighur,
    ukrainian,
    urdu,
    uzbek,
    venda,
    vietnamese,
    volapuk,
    walloon,
    welsh,
    westernFrisian,
    wolof,
    xhosa,
    yiddish,
    yoruba,
    zhuang,
    zulu
  ];
}

/// The languages built into this package, as maps.
///
/// Every map has an 'isoCode', a 'name' and a 'nativeName' key.
@Deprecated('Use Languages.defaultLanguages instead. Will be removed in 0.5.0.')
final List<Map<String, String>> defaultLanguagesList =
    Languages.defaultLanguages
        .map((Language language) => <String, String>{
              'isoCode': language.isoCode,
              'name': language.name,
              'nativeName': language.nativeName,
            })
        .toList();
