import 'package:flutter/cupertino.dart';
import 'package:git_search/screens/home.dart';
import 'package:git_search/screens/search.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> get(BuildContext context) {
    return {
      HomeScreen.routeName: (context) => const HomeScreen(),
      SearchScreen.routeName: (context) => const SearchScreen(),

    };
  }
}