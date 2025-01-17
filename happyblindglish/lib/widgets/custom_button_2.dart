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
    return MergeSemantics(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: const BeveledRectangleBorder(
                side: BorderSide(color: Colors.black)),
            fixedSize: Size(double.nan, AppUtils.buttonMenuHeight)),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
    );
  }
}
