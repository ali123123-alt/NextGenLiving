import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nextgen_living1/screens/Rooms/AddRoom.dart';
import 'package:nextgen_living1/screens/Rooms/Rooms.dart';
import '../screens/signinscreen.dart';
import '../screens/profilescreen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  User? user;
  Map<String, dynamic>? userData;
  String email = "";
  String name = "";

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    fetchUserDetails(user!.uid);
  }

  Future<void> fetchUserDetails(String uid) async {
    final userRef = FirebaseFirestore.instance.collection('user').doc(uid);
    final userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      setState(() {
        userData = userSnapshot.data();
        email = userData?['email'];
        name = userData?['name'];
      });
      print(userData);
      print(email);
      print(name);
    } else {
      print('User document does not exist');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.black,
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              accountName: Text(
                name,
                style: const TextStyle(fontSize: 18),
              ),
              accountEmail: Text(email),
              currentAccountPictureSize: const Size.square(50),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 165, 255, 137),
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 30.0, color: Colors.blue),
                ), //Text
              ), //circleAvatar
            ), //UserAccountDrawerHeader
          ), //DrawerHeader
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(' My Profile '),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text(' Rooms '),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RoomScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.workspace_premium),
            title: const Text(' Go Premium '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.video_label),
            title: const Text(' Saved Videos '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text(' Edit Profile '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SignInScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
