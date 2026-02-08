import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/util/app_dialog.dart';
import '../sign_up_colors.dart';
import '../view_model/sign_up_view_model.dart';
import '../widget/register_form_widget.dart';

/// 新規登録画面
/// ダークモードのモダンなUIで、格闘技フォーラムへの登録を促す画面
class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final _nicknameController = TextEditingController();
  bool _isAgreedToTerms = false;

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUpViewModelProvider);

    // 登録成功時にダイアログを表示
    ref.listen(signUpViewModelProvider, (previous, next) {
      if (next.registeredUser != null && previous?.registeredUser == null) {
        AppDialog.show(
          context: context,
          title: '登録完了',
          message: '登録が完了しました',
        );
      }
      if (next.errorMessage != null && previous?.errorMessage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0A0A),
              Color(0xFF1A0A0A),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                _buildTitleSection(),
                const SizedBox(height: 40),
                RegisterFormSection(controller: _nicknameController),
                const SizedBox(height: 24),
                _buildActionSection(isLoading: state.isLoading),
                const SizedBox(height: 32),
                _buildFooterSection(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }



  /// タイトルセクション
  Widget _buildTitleSection() {
    return const Column(
      children: [
        Text(
          '格闘技コミュニティへ',
          style: TextStyle(
            color: SignUpColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '最強の仲間と、高みを目指せ。',
          style: TextStyle(
            color: SignUpColors.textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  /// アクションセクション
  Widget _buildActionSection({required bool isLoading}) {
    return Column(
      children: [
        // チェックボックス
        Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: _isAgreedToTerms,
                onChanged: isLoading
                    ? null
                    : (value) {
                        setState(() {
                          _isAgreedToTerms = value ?? false;
                        });
                      },
                activeColor: SignUpColors.accent,
                checkColor: SignUpColors.textPrimary,
                side: const BorderSide(
                  color: SignUpColors.textSecondary,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              '利用規約に同意する',
              style: TextStyle(
                color: SignUpColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // 新規登録ボタン
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: isLoading ? null : _onRegisterPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: SignUpColors.accent,
              foregroundColor: SignUpColors.textPrimary,
              disabledBackgroundColor: SignUpColors.accent.withValues(alpha: 0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: SignUpColors.textPrimary,
                      strokeWidth: 2.5,
                    ),
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '新規登録',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,
                        size: 20,
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  /// フッターセクション
  Widget _buildFooterSection() {
    return GestureDetector(
      onTap: () {
        // TODO: ログイン画面への遷移
      },
      child: RichText(
        text: const TextSpan(
          style: TextStyle(
            fontSize: 14,
            color: SignUpColors.textSecondary,
          ),
          children: [
            TextSpan(text: 'すでにアカウントをお持ちですか？ '),
            TextSpan(
              text: 'ログイン',
              style: TextStyle(
                color: SignUpColors.accent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 登録ボタン押下時の処理
  void _onRegisterPressed() {
    ref.read(signUpViewModelProvider.notifier).registerUser(
          name: _nicknameController.text,
          isAgreedToTerms: _isAgreedToTerms,
        );
  }

}
