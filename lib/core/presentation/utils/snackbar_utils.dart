import 'package:flutter/material.dart';
import 'package:pingo/core/theme/app_theme.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class SnackbarUtils {
  static void show(String message,
      {bool isError = false, String? actionLabel, VoidCallback? onAction}) {
    final messenger = rootScaffoldMessengerKey.currentState;
    if (messenger == null) return;

    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? AppColors.error.s500 : null,
        duration: Duration(seconds: isError ? 4 : 2),
        action: actionLabel != null && onAction != null
            ? SnackBarAction(
                label: actionLabel,
                onPressed: onAction,
                textColor: Colors.white,
              )
            : null,
      ),
    );
  }

  static void showError(Object error) {
    final errorStr = error.toString().toLowerCase();
    String userMessage = "Something unexpected happened.";

    if (errorStr.contains('socket') ||
        errorStr.contains('network') ||
        errorStr.contains('connection')) {
      userMessage = "Couldn't connect. Saved locally.";
    } else if (errorStr.contains('location') || errorStr.contains('gps')) {
      userMessage = "GPS lost. We'll keep your place.";
    } else if (errorStr.contains('camera') || errorStr.contains('permission')) {
      userMessage = "Camera unavailable. You can still add a note.";
    } else if (errorStr.contains('database') || errorStr.contains('disk')) {
      userMessage = "Storage full? We couldn't save that.";
    }

    show(userMessage, isError: true);
  }
}
