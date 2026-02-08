/// アプリ全体の設定値を管理するクラス
class AppConfig {
  AppConfig._();

  /// APIのベースURL
  static const String baseUrl = 'http://localhost:8080';

  /// APIのバージョンパス
  static const String apiPath = '/api/v1';
}
