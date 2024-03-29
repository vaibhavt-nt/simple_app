import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/screens/navigation_screen/bottom_navigation_screen.dart';
import 'package:simple_app/screens/splash_screen/splash_screen.dart';
import 'package:simple_app/services/firebase_service/firebase_options.dart';
import 'package:simple_app/services/provider/navigation_provider.dart';
import 'package:simple_app/services/provider/sign_up_provider.dart';

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

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        child: AnnotatedRegion(
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
                      return BottomNavigationBarScreen();
                    } else {
                      return const SplashScreen();
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
