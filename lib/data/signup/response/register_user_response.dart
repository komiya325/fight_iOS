/// ユーザー登録APIのレスポンスDTO
class RegisterUserResponse {
  /// 登録結果のステータス
  final String status;

  /// 登録されたユーザーID
  final String userId;

  const RegisterUserResponse({
    required this.status,
    required this.userId,
  });

  factory RegisterUserResponse.fromJson(Map<String, dynamic> json) {
    return RegisterUserResponse(
      status: json['status'] as String,
      userId: json['user_id'] as String,
    );
  }
}
