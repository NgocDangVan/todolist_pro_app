import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/onboarding/onboarding_page_view.dart';
import 'package:todo_list_app/ui/ui.splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: OnboardingPageView(),
    );
  }
}