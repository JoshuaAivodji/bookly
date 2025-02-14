import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {

  static final EnvConfig _instance = EnvConfig._internal();
  factory EnvConfig() => _instance;
  EnvConfig._internal();

  String _getEnvValue(String key, {String defaultValue = ''}) {
    return dotenv.env[key] ?? defaultValue;
  }

  String get bookApiKey => _getEnvValue('GOOGLE_BOOKS_API_KEY');

}