import 'package:dio/dio.dart';

import '../error/app_exception.dart';
import 'api_response.dart';
import 'http_method.dart';
import 'requestable.dart';

/// Dioを使ったAPI通信クライアント
///
/// [Requestable]を受け取り、通信を実行して[ApiResponse]を返す。
/// 例外をスローせず、常に[ApiResponse]でラップして返す設計。
class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  /// [Requestable]を実行し、[ApiResponse]を返す
  Future<ApiResponse<T>> execute<T>(Requestable<T> request) async {
    try {
      final response = await _performRequest(request);
      final decoded = request.decode(response.data as Map<String, dynamic>);
      return ApiResponse.success(decoded);
    } on DioException catch (e) {
      return ApiResponse.failure(_mapDioException(e));
    }
  }

  /// HTTPメソッドに応じたDioリクエストを実行する
  Future<Response<dynamic>> _performRequest(Requestable<dynamic> request) {
    switch (request.method) {
      case HttpMethod.get:
        return _dio.get(
          request.path,
          queryParameters: request.queryParameters,
        );
      case HttpMethod.post:
        return _dio.post(
          request.path,
          data: request.body,
          queryParameters: request.queryParameters,
        );
      case HttpMethod.put:
        return _dio.put(
          request.path,
          data: request.body,
          queryParameters: request.queryParameters,
        );
      case HttpMethod.delete:
        return _dio.delete(
          request.path,
          data: request.body,
          queryParameters: request.queryParameters,
        );
      case HttpMethod.patch:
        return _dio.patch(
          request.path,
          data: request.body,
          queryParameters: request.queryParameters,
        );
    }
  }

  /// DioExceptionをAppExceptionに変換する
  AppException _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppException.networkError(
          message: 'タイムアウトが発生しました: ${e.message}',
        );
      case DioExceptionType.connectionError:
        return AppException.networkError(
          message: 'ネットワーク接続に失敗しました: ${e.message}',
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode ?? 0;
        return AppException.serverError(
          statusCode: statusCode,
          message: 'サーバーエラーが発生しました（$statusCode）: ${e.message}',
        );
      case DioExceptionType.cancel:
        return AppException.networkError(
          message: 'リクエストがキャンセルされました',
        );
      case DioExceptionType.badCertificate:
        return AppException.networkError(
          message: '不正な証明書です: ${e.message}',
        );
      case DioExceptionType.unknown:
        return AppException.networkError(
          message: '予期しないエラーが発生しました: ${e.message}',
        );
    }
  }
}
