import 'package:language_pickers/languages.dart';
import 'package:flutter/material.dart';

/// Builds the widget shown for [language] inside a picker.
typedef ItemBuilder = Widget Function(Language language);
