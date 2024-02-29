import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_app/splash_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
  ));
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,

      ),
      child: MaterialApp(
        color: Colors.white,

        debugShowCheckedModeBanner: false,
        title: 'Simple App ',
        home: SplashScreen(),
      ),
    );
  }
}
