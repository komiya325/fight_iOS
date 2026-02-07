import 'http_method.dart';

/// APIリクエストの抽象クラス
///
/// 各APIリクエストはこのクラスを継承し、
/// エンドポイント情報とレスポンスのデコード処理を定義する。
abstract class Requestable<T> {
  /// APIのパス（例: "/api/v1/posts"）
  String get path;

  /// HTTPメソッド
  HttpMethod get method;

  /// クエリパラメータ（GETリクエスト等で使用）
  Map<String, dynamic>? get queryParameters => null;

  /// リクエストボディ（POST/PUT等で使用）
  Map<String, dynamic>? get body => null;

  /// JSONレスポンスをドメインモデルに変換する
  T decode(Map<String, dynamic> json);
}
