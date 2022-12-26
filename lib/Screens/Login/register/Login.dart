import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DocumentSnapshot? data;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            //بتجط الاسم اللي بك إياه هون
            Container(
              alignment: Alignment.center,
              child: const Text(
                'ENT5AB',
                style: TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            Container(
              alignment: Alignment.center,
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'example@gmail.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),

            ElevatedButton(
              onPressed: (() async {
                UserCredential user = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);
                data = await FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.user!.uid)
                    .get();
                //log('${data!['role']}');
                if (!mounted) return;
                try {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login Successfully')));

                  if (data!['role'] == 'Candidate') {
                    Navigator.pushNamed(context, 'Candidate');
                  }

                  if (data!['role'] == 'Admin') {
                    Navigator.of(context).pushNamed('Admin');
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('user  does not exist')));
                }
                emailController.clear();
                passwordController.clear();
              }),
              child: const Text('Login'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t you have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'Register');
                  },
                  child: const Text('New Account'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
