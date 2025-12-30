import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:new_apta_grading/core/theme/themes.dart';

extension ContextExt on BuildContext {
  double get height {
    return MediaQuery.of(this).size.height;
  }

  double get width {
    return MediaQuery.of(this).size.width;
  }

  TextScaler textScale(double fontSize) {
    return MediaQuery.of(this).textScaler.scale(fontSize) > 0.9
        ? const TextScaler.linear(0.9)
        : TextScaler.noScaling;
  }

  bool get responsive {
    return MediaQuery.of(this).size.width > 800;
  }

  Future<dynamic> pop([bool? result]) async {
    return Navigator.of(this).pop(result);
  }

  Future<dynamic> push(Widget widget) async {
    return Navigator.of(
      this,
    ).push(MaterialPageRoute(builder: (BuildContext context) => widget));
  }

  Future<dynamic> pushAndRemoveUntil(Widget widget) async {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) => widget),
      (route) => false,
    );
  }

  Future<dynamic> flushBarCustom(
    Color colorBackground,
    String title,
    String msg,
    Widget icon,
    BuildContext context,
    VoidCallback onDismissed,
  ) async {
    return Flushbar(
      titleText: Text(
        title,
        style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
        textScaler: textScale(14),
      ),
      messageText: Text(
        msg,
        style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
        textScaler: textScale(14),
      ),
      backgroundColor: colorBackground,
      flushbarPosition: FlushbarPosition.TOP,
      icon: icon,
      duration: const Duration(seconds: 2),
    ).show(context).then((_) => onDismissed());
  }

  Future<dynamic> flushBottomBarCustom(
    Color colorBackground,
    String title,
    String msg,
    Widget icon,
    BuildContext context,
    VoidCallback onDismissed,
  ) async {
    return Flushbar(
      titleText: Text(
        title,
        style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
        textScaler: textScale(14),
      ),
      messageText: Text(
        msg,
        style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
        textScaler: textScale(14),
      ),
      backgroundColor: colorBackground,
      flushbarPosition: FlushbarPosition.BOTTOM,
      icon: icon,
      duration: const Duration(seconds: 3),
    ).show(context).then((_) => onDismissed());
  }
}
