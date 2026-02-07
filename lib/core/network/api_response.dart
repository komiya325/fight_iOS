import 'package:freezed_annotation/freezed_annotation.dart';

import '../error/app_exception.dart';

part 'api_response.freezed.dart';

/// API通信の結果を表すユニオン型
@freezed
class ApiResponse<T> with _$ApiResponse<T> {
  /// 成功レスポンス
  const factory ApiResponse.success(T data) = ApiSuccess<T>;

  /// 失敗レスポンス
  const factory ApiResponse.failure(AppException exception) = ApiFailure<T>;
}
