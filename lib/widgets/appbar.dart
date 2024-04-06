import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarComp extends StatefulWidget implements PreferredSizeWidget {
  const AppBarComp({super.key});

  @override
  State<AppBarComp> createState() => _AppBarCompState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarCompState extends State<AppBarComp> {
  bool isConnected = false;
  bool gasLeakage = false;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        isConnected = (result != ConnectivityResult.none);
      });
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (gasLeakage && !isConnected) {
        // Check if gasLeakage is true and there is no connectivity
        showGasLeakageScreen(context);
      }
    });
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      isConnected = (connectivityResult != ConnectivityResult.none);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showGasLeakageScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Gas Leakage Detected'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('A gas leakage has been detected in your area.'),
                Text(
                    'Please evacuate immediately and call the emergency hotline.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text(
        "Dashboard",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      centerTitle: true,
      actions: [
        isConnected
            ? const Icon(Icons.wifi)
            : const Icon(Icons.signal_wifi_off),
        const SizedBox(width: 20),
        const Icon(
          Icons.person,
          size: 20,
          color: Colors.white,
        )
      ],
    );
  }
}
