import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.textEditingController,
    required this.hint,
    required this.prefixIcon,

  });

  final String hint ;
  final IconData prefixIcon ;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(prefixIcon),
          enabledBorder: buildOutlineInputBorder(color: Colors.grey),
          focusedBorder: buildOutlineInputBorder(color: Colors.blue),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({ required Color color }) {
    return OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        );
  }
}