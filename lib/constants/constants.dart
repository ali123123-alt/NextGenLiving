import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

// Colors
const kBackgroundColor = Color(0xff191720);
const kTextFieldFill = Color(0xff1E1C24);
// TextStyles
const kHeadline = TextStyle(
  color: Colors.white,
  fontSize: 34,
  fontWeight: FontWeight.bold,
);

const kBodyText = TextStyle(
  color: Colors.white,
  fontSize: 12,
);

const kButtonText = TextStyle(
  color: Colors.black87,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const kBodyText2 =
    TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Colors.white);

const gradient = LinearGradient(
  colors: [Color(0xFF001F3F), Color(0xFF003366)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const gradient1 = LinearGradient(
  colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const gradient2 = LinearGradient(
  colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const logo = CircleAvatar(
  radius: 100.0,
  backgroundImage: AssetImage(
      'assets/images/home_logo.PNG'), // Replace with your actual image path
);

const backarrow = Image(
  width: 24,
  color: Colors.white,
  image: Svg('assets/images/back_arrow.svg'),
);

const projecttitle = Text(
  "NextGen Living.",
  style: kHeadline,
  textAlign: TextAlign.center,
);

final List<String> roomTitles = [
  'Living Room',
  'Bedroom',
  'Kitchen',
  'Bathroom',
  'Office',
  // Add more room titles as needed
];

final List<String> roomImagePaths = [
  'assets/images/Living-Room-Wallpapers-02.jpg',
  'assets/images/Living-Room-Wallpapers-02.jpg',
  'assets/images/Living-Room-Wallpapers-02.jpg',
  'assets/images/Living-Room-Wallpapers-02.jpg',
  'assets/images/Living-Room-Wallpapers-02.jpg',
  // Add more room image paths as needed
];
