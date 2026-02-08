import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/app_exception.dart';
import '../../../domain/usecases/register_user_usecase.dart';
import '../../../providers/usecase/signup/register_user_usecase_provider.dart';
import '../state/sign_up_state.dart';

/// 新規登録画面のViewModel Provider
final signUpViewModelProvider =
    StateNotifierProvider<SignUpViewModel, SignUpState>((ref) {
  final useCase = ref.watch(registerUserUseCaseProvider);
  return SignUpViewModel(useCase);
});

/// 新規登録画面のViewModel
///
/// ニックネームのバリデーションとAPI呼び出しを管理する
class SignUpViewModel extends StateNotifier<SignUpState> {
  final RegisterUserUseCase _registerUserUseCase;

  SignUpViewModel(this._registerUserUseCase) : super(const SignUpState());

  /// ユーザー登録を実行する
  ///
  /// [name] ニックネーム
  /// [isAgreedToTerms] 利用規約への同意状態
  Future<void> registerUser({
    required String name,
    required bool isAgreedToTerms,
  }) async {
    // バリデーション
    if (name.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'ニックネームを入力してください');
      return;
    }

    if (!isAgreedToTerms) {
      state = state.copyWith(errorMessage: '利用規約に同意してください');
      return;
    }

    // ローディング開始
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      registeredUser: null,
    );

    try {
      final user = await _registerUserUseCase.execute(name: name.trim());
      state = state.copyWith(
        isLoading: false,
        registeredUser: user,
      );
    } on AppException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.message,
      );
    }
  }
}
