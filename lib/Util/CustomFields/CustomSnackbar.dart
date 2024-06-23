import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showCustomSnackbar(
    {required String message, required context, required snackbar}) {
  if (snackbar == 'success')
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: message,
      ),
    );
  if (snackbar == 'info')
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        message: message,
      ),
    );
  if (snackbar == 'error')
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: message,
      ),
    );
}
