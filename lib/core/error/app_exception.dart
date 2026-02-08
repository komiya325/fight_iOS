/// アプリケーション全体で使用するエラー型
sealed class AppException implements Exception {
  String get message;
}

/// ネットワークエラー（タイムアウト・接続不可等）
class NetworkError extends AppException {
  @override
  final String message;

  NetworkError({required this.message});
}

/// サーバーエラー（4xx / 5xx）
class ServerError extends AppException {
  final int statusCode;

  @override
  final String message;

  ServerError({required this.statusCode, required this.message});
}
