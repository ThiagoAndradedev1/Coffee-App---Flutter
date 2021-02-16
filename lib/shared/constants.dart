import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  // border: OutlineInputBorder(
  //   borderRadius: const BorderRadius.all(
  //     const Radius.circular(30.0),
  //   ),
  // ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);
