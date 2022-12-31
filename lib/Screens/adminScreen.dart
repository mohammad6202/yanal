import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AHome extends StatefulWidget {
  const AHome({super.key});

  @override
  State<AHome> createState() => _AHomeState();
}

class _AHomeState extends State<AHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin page'),
        actions: [
          IconButton(
              onPressed: (() async {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              }),
              icon: const Icon(Icons.logout))
        ],
      ),
      //drawer: Drawer(),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                opacity: 0.3,
                image: AssetImage(
                    'images/3qI8YA0hrd8FREwagmiNQvdl1NviIqILuMrBlwRE.jpeg'))),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
