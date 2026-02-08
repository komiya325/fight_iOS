import '../error/app_exception.dart';

/// API通信の結果を表すユニオン型
sealed class ApiResponse<T> {}

/// 成功レスポンス
class ApiSuccess<T> extends ApiResponse<T> {
  final T data;

  ApiSuccess(this.data);
}

/// 失敗レスポンス
class ApiFailure<T> extends ApiResponse<T> {
  final AppException exception;

  ApiFailure(this.exception);
}
