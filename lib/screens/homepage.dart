import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../widgets/appbar.dart';

class OffButtonScreen extends StatefulWidget {
  @override
  _OffButtonScreenState createState() => _OffButtonScreenState();
}

class _OffButtonScreenState extends State<OffButtonScreen> {
  DatabaseReference light1ref = FirebaseDatabase.instance.ref('Light/light1');
  DatabaseReference light2ref = FirebaseDatabase.instance.ref('Light/light2');
  DatabaseReference fanref = FirebaseDatabase.instance.ref('Light/fan');
  final _lightRef = FirebaseDatabase.instance.ref('Light');
  bool? lightStatus1 = false;
  bool? lightStatus2 = false;
  bool? fanStatus = false;

  @override
  void initState() {
    super.initState();
    light1ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print('Data received: $data');
      if (data != null) {
        setState(() {
          lightStatus1 = data as bool?;
        });
      }
    });
    light2ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print('Data received: $data');
      if (data != null) {
        setState(() {
          lightStatus2 = data as bool?;
        });
      }
    });
    fanref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print('Data received: $data');
      if (data != null) {
        setState(() {
          fanStatus = data as bool?;
        });
      }
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
                Row(
                  children: [
                    fanStatus == null
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: fanStatus!
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
                                        "assets/images/fan.png",
                                        height: 40,
                                        color: fanStatus!
                                            ? Colors.white
                                            : Colors.grey.shade700,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          "Smart Fan",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: fanStatus!
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _lightRef.update(
                                                {'fan': !(fanStatus ?? false)});
                                          },
                                          child:
                                              Text(fanStatus! ? 'ON' : 'OFF'),
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
