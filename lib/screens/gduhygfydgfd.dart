import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nextgen_living1/widgets/appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  final ref = FirebaseDatabase.instance.ref('Light');
  bool powerOnSmartLight = false;
  bool powerOnSmartAC = false;
  bool powerOnSmartTV = false;
  bool powerOnSmartFan = false;

  @override
  void initState() {
    super.initState();
    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
      if (data != null && data is Map<String, dynamic>) {
        final light = data['Light'];
        if (light != null) {
          setState(() {
            powerOnSmartLight = light;
          });
          print('Light Status: $light');
        }
      }
    });
  }

  // power button switched
  void powerSwitchChanged(bool value, String deviceName) {
    // Update the power status of the device with the specified deviceName
    setState(() {
      switch (deviceName) {
        case 'Smart Light':
          powerOnSmartLight = value; // Update powerOnSmartLight
          break;
        case 'Smart AC':
          powerOnSmartAC = value;
          break;
        case 'Smart TV':
          powerOnSmartTV = value;
          break;
        case 'Smart Fan':
          powerOnSmartFan = value;
          break;
        default:
          // Handle default case
          break;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // app bar
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width /
                          2, // Adjust width as needed
                      child: SmartDeviceBox(
                        smartDeviceName: 'Smart Light',
                        iconPath: 'assets/images/light-bulb.png',
                        powerOn: powerOnSmartLight,
                        onChanged: (value) =>
                            powerSwitchChanged(value, 'Smart Light'),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width /
                          2, // Adjust width as needed
                      child: SmartDeviceBox(
                        smartDeviceName: 'Smart AC',
                        iconPath: 'assets/images/air-conditioner.png',
                        powerOn: powerOnSmartAC,
                        onChanged: (value) =>
                            powerSwitchChanged(value, 'Smart AC'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width /
                          2, // Adjust width as needed
                      child: SmartDeviceBox(
                        smartDeviceName: 'Smart TV',
                        iconPath: 'assets/images/smart-tv.png',
                        powerOn: powerOnSmartTV,
                        onChanged: (value) =>
                            powerSwitchChanged(value, 'Smart TV'),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width /
                          2, // Adjust width as needed
                      child: SmartDeviceBox(
                        smartDeviceName: 'Smart Fan',
                        iconPath: 'assets/images/fan.png',
                        powerOn: powerOnSmartFan,
                        onChanged: (value) =>
                            powerSwitchChanged(value, 'Smart Fan'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // grid
          ],
        ),
      ),
    );
  }
}

class SmartDeviceBox extends StatefulWidget {
  final String smartDeviceName;
  final String iconPath;
  final bool powerOn;
  final void Function(bool)? onChanged;

  const SmartDeviceBox({
    Key? key,
    required this.smartDeviceName,
    required this.iconPath,
    required this.powerOn,
    required this.onChanged,
  }) : super(key: key);

  @override
  _SmartDeviceBoxState createState() => _SmartDeviceBoxState();
}

class _SmartDeviceBoxState extends State<SmartDeviceBox> {
  late bool _powerOn;

  @override
  void initState() {
    super.initState();
    _powerOn = widget.powerOn;
  }

  @override
  void didUpdateWidget(SmartDeviceBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.powerOn != _powerOn) {
      setState(() {
        _powerOn = widget.powerOn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: _powerOn
              ? Colors.grey[900]
              : const Color.fromARGB(44, 164, 167, 189),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // icon
              Image.asset(
                widget.iconPath,
                height: 40,
                color: _powerOn ? Colors.white : Colors.grey.shade700,
              ),
              // smart device name + switch
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        widget.smartDeviceName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: _powerOn ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: pi / 2,
                    child: Switch(
                      value: _powerOn,
                      onChanged: (value) {
                        setState(() {
                          _powerOn = value;
                        });
                        widget.onChanged?.call(value);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
