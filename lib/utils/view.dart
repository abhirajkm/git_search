import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

double fullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double fullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

class ViewUtils {
  static void showMessage({required String message}) {
    print(message);
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
  }

  static double fourInch = 600.0;
  static double fivePointSixInch = 760.0;

  static bool _isLoading = false;

  static void showLoader(BuildContext context) {
    if (!_isLoading) {
      _isLoading = true;
      _showAppLoader(context);
    }
  }

  static _showAppLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Container(
        height: 75.0,
        width: 75.0,
        alignment: Alignment.center,
        child: SpinKitFadingCircle(
          size: 50.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  static Future<bool> isInternetConnected() async {
    var connectionStatus = await Connectivity().checkConnectivity();

    if (connectionStatus == ConnectivityResult.none) {
      ViewUtils.showMessage(message: "You are not connected to the internet");
    }
    return connectionStatus != ConnectivityResult.none;
  }
}
