import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yanal/Screens/Login/register/Register.dart';
import 'package:yanal/Screens/candidateScreen.dart';
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
      'Candidate': (context) => const CandidateScreen(),
    },
    home: handleAuthState(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future getRoleType() async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final data =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  if (data['role'] == 'Candidate') {
    return const CandidateScreen();
  }
  if (data['role'] == 'Admin') {
    return const AHome();
  }
}

handleAuthState() {
  return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          getRoleType();
        }
        return const LoginScreen();
      });
}
