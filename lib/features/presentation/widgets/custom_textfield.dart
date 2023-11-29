import 'package:flutter/material.dart';
import '../../../main.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.label,
      required this.inputType,
      required this.controller});
  final String label;
  final TextInputType inputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: styles.f12SemiBold(),
        ),
        TextField(
          controller: controller,
          keyboardType: inputType,
          cursorColor: orange,
          decoration: const InputDecoration(
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: orange)),
          ),
        ),
      ],
    );
  }
}
