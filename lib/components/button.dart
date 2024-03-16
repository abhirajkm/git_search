import 'package:flutter/material.dart';

import '../utils/theme.dart';

class Button extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final Color? color;
  final bool loading;
  final double height;
  final double? width;
  const Button({super.key, required this.title, this.onPressed,
    this.color=Colors.purple,  required this.loading, this.height=50.0, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
       style: TextButton.styleFrom(
          elevation: 3.0,
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(15))),
        onPressed: onPressed,
        child:  loading ? const SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 1.5,
          ),
        ):Text(title, style:buttonStyle,),
      ),
    );
  }
}