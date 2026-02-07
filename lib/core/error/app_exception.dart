import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

/// アプリケーション全体で使用するエラー型
@freezed
class AppException with _$AppException {
  /// ネットワークエラー（タイムアウト・接続不可等）
  const factory AppException.networkError({
    required String message,
  }) = NetworkError;

  /// サーバーエラー（4xx / 5xx）
  const factory AppException.serverError({
    required int statusCode,
    required String message,
  }) = ServerError;
}
