import 'package:flutter/material.dart';

import '../constants/constants.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.hintText,
    required this.inputType,
    required this.icon,
  }) : super(key: key);
  final String hintText;
  final TextInputType inputType;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        style: kBodyText.copyWith(color: Colors.white),
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: icon,
          contentPadding: EdgeInsets.all(20),
          hintText: hintText,
          hintStyle: kBodyText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
