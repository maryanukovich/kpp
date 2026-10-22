import 'package:flutter/material.dart';

/// Показує SnackBar для демонстраційних дій без бізнес-логіки.
void showDemoMessage(BuildContext context, String message) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(SnackBar(content: Text(message)));
}
