import 'package:flutter/material.dart';

/// アプリ共通のダイアログユーティリティ
class AppDialog {
  AppDialog._();

  /// 共通ダイアログを表示する
  ///
  /// [title] ダイアログのタイトル
  /// [message] ダイアログのメッセージ
  /// [buttonText] ボタンのテキスト（デフォルト: 'OK'）
  /// [onPressed] ボタン押下時のコールバック（nullの場合はダイアログを閉じる）
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            color: Color(0xFF8E8E93),
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onPressed?.call();
            },
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Color(0xFFFF3B3B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
