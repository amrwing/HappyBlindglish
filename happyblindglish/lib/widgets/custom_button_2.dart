import 'package:flutter/material.dart';
import 'package:happyblindglish/utils/app_utils.dart';

class CustomButton2 extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const CustomButton2({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffd6382d),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(AppUtils.buttonBorderRadius)),
              side: const BorderSide(color: Colors.black)),
          fixedSize: Size(double.nan, AppUtils.buttonMenuHeight)),
      child: Padding(
        padding: const EdgeInsets.all(AppUtils.textButtonPadding),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
