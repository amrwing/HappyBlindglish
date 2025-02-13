import 'package:flutter/material.dart';
import 'package:happyblindglish/utils/app_utils.dart';

class CustomButton1 extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const CustomButton1({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            disabledBackgroundColor: Colors.grey,
            backgroundColor: const Color(0xff8755c9),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(AppUtils.buttonBorderRadius)),
                side: const BorderSide(color: Colors.black)),
            fixedSize: Size(double.maxFinite, AppUtils.buttonMenuHeight)),
        child: Padding(
          padding: const EdgeInsets.all(AppUtils.textButtonPadding),
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
