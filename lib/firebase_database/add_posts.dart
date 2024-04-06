import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import '../widgets/round_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  final tempRef = FirebaseDatabase.instance.ref('Temp');
  final WaterRef = FirebaseDatabase.instance.ref('WaterLevel');
  final LightRef = FirebaseDatabase.instance.ref('Light');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: const InputDecoration(
                  hintText: 'What is in your mind?',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundButton(
                title: 'Add',
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;
                  });

                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  databaseRef.child(id).set({
                    'title': postController.text.toString(),
                    'id': DateTime.now().millisecondsSinceEpoch.toString()
                  }).then((value) {
                    Utils().toastMessage('Post added');
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });

                  // tempRef.set({'temp': 60, 'humidity': 60}).then((value) {
                  //   Utils().toastMessage('Temp added');
                  //   setState(() {
                  //     loading = false;
                  //   });
                  // }).onError((error, stackTrace) {
                  //   Utils().toastMessage(error.toString());
                  //   setState(() {
                  //     loading = false;
                  //   });
                  // });

                  // WaterRef.set({'WaterLevel': 60}).then((value) {
                  //   Utils().toastMessage('Water Level added');
                  //   setState(() {
                  //     loading = false;
                  //   });
                  // }).onError((error, stackTrace) {
                  //   Utils().toastMessage(error.toString());
                  //   setState(() {
                  //     loading = false;
                  //   });
                  // });

                  LightRef.set({'light': false}).then((value) {
                    Utils().toastMessage('Light added');
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
                })
          ],
        ),
      ),
    );
  }
}
