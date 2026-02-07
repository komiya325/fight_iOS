import 'package:flutter/material.dart';

import '../sign_up_colors.dart';
import '../widget/register_form_widget.dart';

/// 新規登録画面
/// ダークモードのモダンなUIで、格闘技フォーラムへの登録を促す画面
class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool _isAgreedToTerms = false;

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 40),
                // ヘッダーエリア
                _buildHeaderSection(),
                const SizedBox(height: 32),
                // メインタイトル
                _buildTitleSection(),
                const SizedBox(height: 40),
                // 入力フォームエリア
                const RegisterFormSection(),
                const SizedBox(height: 24),
                // アクションエリア
                _buildActionSection(),
                const SizedBox(height: 32),
                // フッター
                _buildFooterSection(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ヘッダーセクション
  Widget _buildHeaderSection() {
    return Column(
      children: [
        // フォーラム名
        const Text(
          'MARTIAL ARTS FORUM',
          style: TextStyle(
            color: SignUpColors.accent,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 16),
        // カプセル型バッジ
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: SignUpColors.badgeBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: SignUpColors.accent,
              width: 1,
            ),
          ),
          child: const Text(
            'JOIN THE ELITE',
            style: TextStyle(
              color: SignUpColors.accent,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ],
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
  Widget _buildActionSection() {
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
                onChanged: (value) {
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
            onPressed: () {
              // TODO: 新規登録処理
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: SignUpColors.accent,
              foregroundColor: SignUpColors.textPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Row(
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
}
