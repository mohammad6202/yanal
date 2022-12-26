import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CandidateScreen extends StatefulWidget {
  const CandidateScreen({super.key});

  @override
  State<CandidateScreen> createState() => _CandidateScreenState();
}

class _CandidateScreenState extends State<CandidateScreen> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  DocumentSnapshot? data;
  Future get(BuildContext context) async {
    data = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Candidate Page'),
        actions: [
          IconButton(
              onPressed: (() {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              }),
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      drawer: Drawer(),
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
