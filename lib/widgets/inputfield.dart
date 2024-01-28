import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool obscureText;
  final TextInputType keyboardType;

  const InputField({
    Key? key,
    required this.labelText,
    required this.prefixIcon,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon, color: Colors.white),
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: _border(),
        errorBorder: _border(),
        focusedBorder: _border(),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white, width: 1),
      borderRadius: BorderRadius.circular(18),
    );
  }
}
