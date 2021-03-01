import 'dart:convert';

import 'package:flutter/services.dart';

class Env {
  static Map<String, dynamic> _env;
  static String _envType;

  static Future<void> init() async {
    _env = json.decode(await rootBundle.loadString('.env'));
    _envType = _env['environment'];
  }

  /// Get API Url.
  ///
  ///
  static String get apiUrl => _env[_envType]['apiUrl'];
}

