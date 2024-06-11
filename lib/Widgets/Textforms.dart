import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;

  const TextForm({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputborder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: Divider.createBorderSide(context));
    return Padding(
      padding: const EdgeInsets.only(
        left: 38,
        top: 20,
        right: 38,
      ),
      child: TextFormField(
        
        controller: textEditingController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter $hintText";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.white,
          border: inputborder,
          enabledBorder: inputborder,
          filled: true,
          contentPadding: const EdgeInsets.all(18),
        ),
        keyboardType: textInputType,
        obscureText: isPass,
      ),
    );
  }
}
