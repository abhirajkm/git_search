import 'package:flutter/material.dart';
import 'package:git_search/providers/index.dart';
import 'package:git_search/routes.dart';
import 'package:git_search/screens/home.dart';
import 'package:git_search/utils/text.dart';
import 'package:git_search/utils/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderTree.get(context),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: appTheme,
        home: const HomeScreen(),
        routes: AppRoutes.get(context),
      ),
    );
  }
}
