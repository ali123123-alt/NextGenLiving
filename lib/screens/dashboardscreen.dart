import "package:audioplayers/audioplayers.dart";
import "package:flutter/material.dart";
import "package:nextgenliving/screens/homepage.dart";

import "../widgets/appdrawer.dart";

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
      backgroundColor: const Color(0x00018aa3),
      body: Container(
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
            children: [
              const Text(
                'Welcome To User!!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    DashboardCard(
                      title: 'Water Level',
                      icon: Icons.water,
                      onTap: () {
                        // Handle Water Level tap
                      },
                    ),
                    DashboardCard(
                      title: 'Gas Leakage',
                      icon: Icons.smoking_rooms,
                      onTap: () {
                        // Handle Gas Leakage tap
                      },
                    ),
                    DashboardCard(
                      title: 'Living Room',
                      icon: Icons.tv,
                      onTap: () {
                        // Handle Living Room tap
                      },
                    ),
                    DashboardCard(
                      title: 'Bedroom',
                      icon: Icons.lightbulb_outline,
                      onTap: () {
                        // Handle Bedroom tap
                      },
                    ),
                    DashboardCard(
                      title: 'Security',
                      icon: Icons.security,
                      onTap: () {
                        final player = AudioPlayer();
                        player.play(AssetSource('siren.mp3'));
                      },
                    ),
                    DashboardCard(
                      title: 'Temperature',
                      icon: Icons.thermostat_outlined,
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HomePage()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DashboardCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: Colors.blue,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
