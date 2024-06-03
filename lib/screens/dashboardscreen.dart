import "package:audioplayers/audioplayers.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:nextgen_living1/screens/GasLeakageScreen.dart";
import "package:nextgen_living1/screens/WaterLevelScreen.dart";
import "package:nextgen_living1/screens/temperaturescreen.dart";
import "package:nextgen_living1/widgets/appbar.dart";
import "../widgets/appdrawer.dart";
import "../widgets/dashboardcard.dart";
import "homepage.dart";

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComp(),
      drawer: const AppDrawer(),
      backgroundColor: const Color(0x00018aa3),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF001F3F), Color(0xFF003366)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Home,",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                    height: 200, // Height of the room cards
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          RoomCard(
                            title: 'Living Room',
                            imagePath:
                                'assets/images/Living-Room-Wallpapers-02.jpg',
                          ),
                          RoomCard(
                            title: 'Bedroom',
                            imagePath:
                                'assets/images/Living-Room-Wallpapers-02.jpg',
                          ),
                          RoomCard(
                            title: 'Kitchen',
                            imagePath:
                                'assets/images/Living-Room-Wallpapers-02.jpg',
                          ),
                          RoomCard(
                            title: 'Bathroom',
                            imagePath:
                                'assets/images/Living-Room-Wallpapers-02.jpg',
                          ),
                          RoomCard(
                            title: 'Office',
                            imagePath:
                                'assets/images/Living-Room-Wallpapers-02.jpg',
                          )
                        ])),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DashboardCard(
                            title: 'Water Level',
                            icon: Icons.water,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const WaterLevelScreen()));
                            },
                          ),
                        ),
                        Expanded(
                          child: DashboardCard(
                            title: 'Gas Leakage',
                            icon: Icons.smoking_rooms,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const GasLeakageScreen()));
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DashboardCard(
                            title: 'Security',
                            icon: Icons.security,
                            onTap: () {
                              final player = AudioPlayer();
                              player.play(AssetSource('siren.mp3'));
                            },
                          ),
                        ),
                        Expanded(
                          child: DashboardCard(
                            title: 'Temperature',
                            icon: Icons.thermostat_outlined,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const TemperatureScreen()));
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const RoomCard({required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0), // Adjust the value as needed
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => OffButtonScreen(),
                ),
              );
            },
            child: Container(
              width: 150, // Width of the room cards
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
