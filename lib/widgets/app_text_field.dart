import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.textController,
    required this.hint,
    required this.prefixIcon,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  final TextEditingController textController;
  final String hint;
  final IconData prefixIcon;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(prefixIcon),
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(borderColor: Colors.blue)
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(
      {Color borderColor = Colors.grey}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 1,
        color: borderColor,
      ),
    );
  }
}
