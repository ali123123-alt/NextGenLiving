import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nextgen_living1/widgets/appbar.dart';

import '../../utils/utils.dart';
import '../../widgets/round_button.dart';

class AddRoomScreen extends StatefulWidget {
  const AddRoomScreen({Key? key}) : super(key: key);

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  final postController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Room');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComp(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.lightBlueAccent],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: postController,
                decoration: const InputDecoration(
                    hintText: 'Add Room', border: OutlineInputBorder()),
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

                    String id =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    databaseRef.child(id).set({
                      'title': postController.text.toString(),
                      'id': DateTime.now().millisecondsSinceEpoch.toString()
                    }).then((value) {
                      Utils().toastMessage('Room added');
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
      ),
    );
  }
}
