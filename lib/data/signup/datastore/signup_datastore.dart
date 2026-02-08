import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import '../../../domain/entity/user.dart';
import '../request/register_user_request.dart';

/// 新規登録機能のDataStore
///
/// API通信を実行し、レスポンスDTOをドメインエンティティに変換する
class SignupDataStore {
  final ApiClient _apiClient;

  SignupDataStore(this._apiClient);

  /// ユーザー登録APIを呼び出し、User Entityを返す
  ///
  /// 失敗時はAppExceptionをスローする
  Future<User> registerUser({required String name}) async {
    final request = RegisterUserRequest(name: name);
    final response = await _apiClient.execute(request);

    return switch (response) {
      ApiSuccess(:final data) => User(userId: data.userId, name: name),
      ApiFailure(:final exception) => throw exception,
    };
  }
}
