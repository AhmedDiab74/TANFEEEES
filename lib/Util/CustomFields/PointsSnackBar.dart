import 'package:wowondertimelineflutterapp/String.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

void PointsSnackbar({required String message, required context}) {
  if (Points_System)
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: message,
      ),
    );
}
