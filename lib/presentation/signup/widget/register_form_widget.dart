import 'package:flutter/material.dart';

import '../sign_up_colors.dart';

/// 登録フォームセクション
/// ニックネームの入力欄を表示するWidget
class RegisterFormSection extends StatelessWidget {
  /// テキスト入力のコントローラー
  final TextEditingController controller;

  const RegisterFormSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ニックネーム',
          style: TextStyle(
            color: SignUpColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(
            color: SignUpColors.textPrimary,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintText: 'ニックネームを入力',
            hintStyle: const TextStyle(
              color: SignUpColors.textSecondary,
              fontSize: 16,
            ),
            prefixIcon: const Icon(
              Icons.person_outline,
              color: SignUpColors.textSecondary,
            ),
            filled: true,
            fillColor: SignUpColors.cardBackground,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: SignUpColors.cardBorder,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: SignUpColors.accent,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
