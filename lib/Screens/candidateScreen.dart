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

  List degrees = [
    'Bachelor',
    'Master',
    'PHD',
    'Diploma',
    'High School',
    'High Diploma',
    'Other'
  ];
  String? degree;
  TextEditingController jobC = TextEditingController();
  TextEditingController elecStatC = TextEditingController();
  TextEditingController major = TextEditingController();
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() {
    final auth = FirebaseAuth.instance;
    final User user = auth.currentUser!;
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
      drawer: const CDrawer(),
      body: Form(
        child: Container(
          margin: const EdgeInsets.all(20),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(right: 220),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 60),
                      child: Text(
                        'Degree',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    DropdownButton(
                        value: degree,
                        items: degrees
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text('$e'),
                              ),
                            )
                            .toList(),
                        onChanged: ((value) {
                          setState(() {
                            degree = value.toString();
                          });
                        })),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.only(bottom: 5),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Major',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextFormField(
                controller: major,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.only(bottom: 5),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Job Role',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextFormField(
                controller: jobC,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.only(bottom: 5),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Discreption',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextFormField(
                controller: elecStatC,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        jobC.clear();
                        elecStatC.clear();
                        major.clear();
                      },
                      child: const Text('Clear')),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(onPressed: () {}, child: const Text('Submit'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CDrawer extends StatelessWidget {
  const CDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20,
      child: Column(
        verticalDirection: VerticalDirection.up,
        children: [
          const SizedBox(
            height: 50,
          ),
          ListTile(
            onTap: () {},
            title: const Text('Log Out'),
            trailing: const Icon(Icons.logout),
          ),
          const SizedBox(
            height: 150,
          ),
          ListTile(
            onTap: () {},
            title: const Text('------'),
          ),
          ListTile(
            onTap: () {},
            title: const Text('------'),
          ),
          ListTile(
            onTap: () {},
            title: const Text('Candidacy'),
          ),
          ListTile(
            onTap: () {},
            title: const Text('Profile'),
            trailing: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
    );
  }
}
