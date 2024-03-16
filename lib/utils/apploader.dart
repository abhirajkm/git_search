import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoader extends StatelessWidget {
  final double? size;

  const AppLoader({Key? key, this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        size: size ?? 50.0,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
