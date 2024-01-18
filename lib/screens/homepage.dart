import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nextgenliving/widgets/appdrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;

  // list of smart devices
  List mySmartDevices = [
    // [ smartDeviceName, iconPath , powerStatus ]
    ["Smart Light", "assets/images/light-bulb.png", true],
    ["Smart AC", "assets/images/air-conditioner.png", false],
    ["Smart TV", "assets/images/smart-tv.png", false],
    ["Smart Fan", "assets/images/fan.png", false],
  ];

  // power button switched
  void powerSwitchChanged(bool value, int index) {
    setState(() {
      mySmartDevices[index][2] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: const [
          Icon(
            Icons.person,
            size: 20,
            color: Colors.white,
          )
        ],
      ),
      drawer: const AppDrawer(),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // app bar
            const SizedBox(height: 10),
            // welcome home
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Home,",
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade800),
                  ),
                  Text(
                    'Mitch Koko',
                    style: GoogleFonts.bebasNeue(fontSize: 30),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Center(
                child: isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CustomPaint(
                            foregroundPainter: CircleProgress(70, true),
                            child: const SizedBox(
                              width: 150,
                              height: 150,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Temperature',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    Text(
                                      '70',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '°C',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          CustomPaint(
                            foregroundPainter: CircleProgress(60, false),
                            child: const SizedBox(
                              width: 120,
                              height: 120,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Humidity',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    Text(
                                      '60',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '%',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : const Text(
                        'Loading...',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      )),
            // smart devices grid
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
            // grid
            Expanded(
              child: GridView.builder(
                itemCount: 4,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.2,
                ),
                itemBuilder: (context, index) {
                  return SmartDeviceBox(
                    smartDeviceName: mySmartDevices[index][0],
                    iconPath: mySmartDevices[index][1],
                    powerOn: mySmartDevices[index][2],
                    onChanged: (value) => powerSwitchChanged(value, index),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SmartDeviceBox extends StatelessWidget {
  final String smartDeviceName;
  final String iconPath;
  final bool powerOn;
  void Function(bool)? onChanged;

  SmartDeviceBox({
    super.key,
    required this.smartDeviceName,
    required this.iconPath,
    required this.powerOn,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: powerOn
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
                iconPath,
                height: 40,
                color: powerOn ? Colors.white : Colors.grey.shade700,
              ),
              // smart device name + switch
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        smartDeviceName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: powerOn ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: pi / 2,
                    child: CupertinoSwitch(
                      value: powerOn,
                      onChanged: onChanged,
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

class CircleProgress extends CustomPainter {
  double value;
  bool isTemp;

  CircleProgress(this.value, this.isTemp);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    int maximumValue =
        isTemp ? 50 : 100; // Temp's max is 50, Humidity's max is 100

    Paint outerCircle = Paint()
      ..strokeWidth = 14
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    Paint tempArc = Paint()
      ..strokeWidth = 14
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint humidityArc = Paint()
      ..strokeWidth = 14
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 14;
    canvas.drawCircle(center, radius, outerCircle);

    double angle = 2 * pi * (value / maximumValue);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, isTemp ? tempArc : humidityArc);
  }
}
