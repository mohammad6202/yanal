import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yanal/Screens/Login/register/Register.dart';

import 'Screens/Login/register/Login.dart';
import 'Screens/adminScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      'Admin': (context) => const AHome(),
      'Login': (context) => const LoginScreen(),
      'Register': ((context) => const RegisterScreen()),
    },
    home: handleAuthState(),
  ));
}

handleAuthState() {
  return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return const AHome();
        } else {
          return const LoginScreen();
        }
      });
}
