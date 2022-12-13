import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  String type = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
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
                  "Create new Account",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameC,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Name',
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
                  controller: emailC,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
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
                  controller: passwordC,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
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
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 250),
                child: Text(
                  'Sign up as :',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              RadioListTile(
                  groupValue: type,
                  title: const Text('Voter'),
                  value: 'Voter',
                  onChanged: ((val) {
                    setState(() {
                      type = val!;
                    });
                  })),
              RadioListTile(
                  groupValue: type,
                  title: const Text('Candidate'),
                  value: 'Candidate',
                  onChanged: ((val) {
                    setState(() {
                      type = val!;
                    });
                  })),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: (() async {
                  final auth = FirebaseAuth.instance;

                  UserCredential user =
                      await auth.createUserWithEmailAndPassword(
                          email: emailC.text, password: passwordC.text);
                  try {
                    final docUser = await FirebaseFirestore.instance
                        .collection('users')
                        .doc();
                    docUser.set({
                      'id': docUser.id,
                      'Name': nameC.text.toString().trim(),
                      'email': emailC.text.toString().trim(),
                      'role': type.toString()
                    });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Registered Successfully')));
                    Navigator.pushNamed(context, 'Admin');
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('user  alreaady in use')));
                  }
                }),
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
