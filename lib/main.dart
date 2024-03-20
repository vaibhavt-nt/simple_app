import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/Provider/provider.dart';
import 'package:simple_app/screens/navigation_screen/bottom_navigation_screen.dart';
import 'package:simple_app/screens/splash_screen/splash_screen.dart';
import 'package:simple_app/services/firebase_service/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //for firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(
    const Wrapper(),
  );
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
                  ? const BottomNavigationBarScreen()
                  : const SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ScaffoldMessenger(
          child: Scaffold(
            body: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const BottomNavigationBarScreen();
                } else {
                  return const SplashScreen();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
