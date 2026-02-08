import '../../../domain/entity/user.dart';

/// 新規登録画面のState
class SignUpState {
  /// ローディング中かどうか
  final bool isLoading;

  /// 登録成功時のユーザー情報
  final User? registeredUser;

  /// エラーメッセージ
  final String? errorMessage;

  const SignUpState({
    this.isLoading = false,
    this.registeredUser,
    this.errorMessage,
  });

  SignUpState copyWith({
    bool? isLoading,
    User? registeredUser,
    String? errorMessage,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      registeredUser: registeredUser ?? this.registeredUser,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
