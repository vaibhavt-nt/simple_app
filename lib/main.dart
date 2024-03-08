import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/Navigation/navigation_screen.dart';
import 'package:simple_app/Provider/provider.dart';
import 'package:simple_app/splash_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UiProvider()..initStorage(),
      child: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return AnnotatedRegion(
            value: const SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.transparent,
              statusBarColor: Colors.transparent,
            ),
            child: MaterialApp(
              color: Colors.white,
              debugShowCheckedModeBanner: false,
              title: 'Simple App ',
              home: notifier.rememberMe
                  ? const NavigationScreen()
                  : const SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}
