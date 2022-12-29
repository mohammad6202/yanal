import 'dart:ffi';

import 'package:age_calculator/age_calculator.dart';
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
  TextEditingController age = TextEditingController();
  GlobalKey<FormState> myFormKey = GlobalKey();
  String type = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: myFormKey,
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
                    labelText: 'Full ',
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
              Container(
                margin: EdgeInsets.only(right: 290),
                width: 100,
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: age,
                    validator: (value) {
                      if (int.parse(value.toString()) < 18) {
                        return 'You are too young for Election program';
                      }
                      if (value!.isEmpty) {
                        return 'this field is Requiered';
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'age',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    )),
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
                  if (myFormKey.currentState!.validate()) {
                    final auth = FirebaseAuth.instance;

                    UserCredential user =
                        await auth.createUserWithEmailAndPassword(
                            email: emailC.text, password: passwordC.text);

                    try {
                      final docUser = FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.user!.uid);
                      docUser.set({
                        'age': age.text,
                        'id': docUser.id,
                        'Full name': nameC.text.toString().trim(),
                        'email': emailC.text.toString().trim(),
                        'role': type.toString()
                      });
                      DocumentSnapshot data = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.user!.uid)
                          .get();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Registered Successfully')));
                      if (data['role'] == 'Candidate') {
                        Navigator.pushReplacementNamed(context, 'Candidate');
                      }
                      if (data['role'] == 'Voter') {
                        Navigator.pushReplacementNamed(context, 'Voter');
                      }
                      if (data['role'] == 'Adimn') {
                        Navigator.pushReplacementNamed(context, 'Admin');
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('user  alreaady in use')));
                    }
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
