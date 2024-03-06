import 'package:flutter/material.dart';

Widget customTextfield({hint, controller}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
        hintText: hint,
        border:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
  );
}
