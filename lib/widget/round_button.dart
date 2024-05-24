import 'package:firebase_mxpert/utils/constant.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final bool? loading;
  final Color? color;
  final VoidCallback onTap;
  const RoundedButton(
      {Key? key,
      required this.title,
      required this.onTap,
      this.loading = false,
      this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: color ?? AppColor().primaryColor,
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: loading == true
              ? const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                )
              : Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                ),
        ),
      ),
    );
  }
}
