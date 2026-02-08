import '../../../core/config/app_config.dart';
import '../../../core/network/http_method.dart';
import '../../../core/network/requestable.dart';
import '../response/register_user_response.dart';

/// ユーザー登録APIのリクエスト
class RegisterUserRequest extends Requestable<RegisterUserResponse> {
  final String name;

  RegisterUserRequest({required this.name});

  @override
  String get path => '${AppConfig.apiPath}/request';

  @override
  HttpMethod get method => HttpMethod.post;

  @override
  Map<String, dynamic>? get body => {
        'api': 'register_user',
        'name': name,
      };

  @override
  RegisterUserResponse decode(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return RegisterUserResponse.fromJson(data);
  }
}
