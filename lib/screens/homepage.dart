import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../widgets/appbar.dart';

class OffButtonScreen extends StatefulWidget {
  @override
  _OffButtonScreenState createState() => _OffButtonScreenState();
}

class _OffButtonScreenState extends State<OffButtonScreen> {
  late DatabaseReference _lightRef;
  bool? lightStatus1;
  bool? lightStatus2;

  @override
  void initState() {
    super.initState();
    _lightRef = FirebaseDatabase.instance.reference().child('Light');
    _lightRef.onValue.listen((event) {
      setState(() {
        lightStatus1 =
            (event.snapshot.value as Map<String, dynamic>?)?['light1'] as bool?;
        lightStatus2 =
            (event.snapshot.value as Map<String, dynamic>?)?['light2'] as bool?;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComp(),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Smart Devices",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Row(
                  children: [
                    lightStatus1 == null
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: lightStatus1!
                                      ? Colors.grey[900]
                                      : const Color.fromARGB(44, 164, 167, 189),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // icon
                                      Image.asset(
                                        "assets/images/light-bulb.png",
                                        height: 40,
                                        color: lightStatus1!
                                            ? Colors.white
                                            : Colors.grey.shade700,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          "Smart Light",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: lightStatus1!
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _lightRef.update({
                                              'light1': !(lightStatus1 ?? false)
                                            });
                                          },
                                          child: Text(
                                              lightStatus1! ? 'ON' : 'OFF'),
                                        ),
                                      ),
                                      // smart device name + switch
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                    lightStatus2 == null
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: lightStatus2!
                                      ? Colors.grey[900]
                                      : const Color.fromARGB(44, 164, 167, 189),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // icon
                                      Image.asset(
                                        "assets/images/light-bulb.png",
                                        height: 40,
                                        color: lightStatus2!
                                            ? Colors.white
                                            : Colors.grey.shade700,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          "Smart Light",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: lightStatus2!
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _lightRef.update({
                                              'light2': !(lightStatus2 ?? false)
                                            });
                                          },
                                          child: Text(
                                              lightStatus2! ? 'ON' : 'OFF'),
                                        ),
                                      ),
                                      // smart device name + switch
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
