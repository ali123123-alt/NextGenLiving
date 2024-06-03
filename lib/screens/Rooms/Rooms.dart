import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:nextgen_living1/screens/Rooms/AddRoom.dart';
import 'package:nextgen_living1/screens/signinscreen.dart';
import 'package:nextgen_living1/widgets/appbar.dart';

import '../../utils/utils.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Room');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
        child: Column(
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  defaultChild: const Text('Loading'),
                  itemBuilder: (context, snapshot, animation, index) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      trailing: PopupMenuButton(
                          color: Colors.white,
                          elevation: 4,
                          padding: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                          icon: const Icon(
                            Icons.more_vert,
                          ),
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 1,
                                  child: PopupMenuItem(
                                    value: 2,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);

                                        ref
                                            .child(snapshot
                                                .child('id')
                                                .value
                                                .toString())
                                            .update({'title': 'nice world'})
                                            .then((value) {})
                                            .onError((error, stackTrace) {
                                              Utils().toastMessage(
                                                  error.toString());
                                            });
                                      },
                                      leading: const Icon(Icons.edit),
                                      title: const Text('Edit'),
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context);

                                      // ref.child(snapshot.child('id').value.toString()).update(
                                      //     {
                                      //       'ttitle' : 'hello world'
                                      //     }).then((value){
                                      //
                                      // }).onError((error, stackTrace){
                                      //   Utils().toastMessage(error.toString());
                                      // });
                                      ref
                                          .child(snapshot
                                              .child('id')
                                              .value
                                              .toString())
                                          .remove()
                                          .then((value) {})
                                          .onError((error, stackTrace) {
                                        Utils().toastMessage(error.toString());
                                      });
                                    },
                                    leading: const Icon(Icons.delete_outline),
                                    title: const Text('Delete'),
                                  ),
                                ),
                              ]),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddRoomScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
