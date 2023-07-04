import 'package:flutter/material.dart';

class ConstTextField extends StatefulWidget {
  const ConstTextField({Key? key, required this.onChanged, required this.text})
      : super(key: key);
  final Function(String) onChanged;
  final String text;
  @override
  State<ConstTextField> createState() => _ConstTextFieldState();
}

class _ConstTextFieldState extends State<ConstTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      keyboardType: TextInputType.number,
      maxLines: 1,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        filled: true,
        hintMaxLines: 1,
        fillColor: const Color(0xffF9F9F9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(20),
        hintText: widget.text,
      ),
    );
  }
}
