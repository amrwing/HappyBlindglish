import 'package:flutter/material.dart';
import 'package:happyblindglish/utils/app_utils.dart';

class CustomButton3 extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const CustomButton3({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          shape: const BeveledRectangleBorder(),
          backgroundColor: Colors.grey,
          fixedSize:
              const Size(double.maxFinite, AppUtils.customButton3Height)),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(color: Colors.black, fontSize: 24),
      ),
    );
  }
}
