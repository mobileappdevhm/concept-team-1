import 'package:flutter/material.dart';

class MyStyle {
  static TextStyle getStyle() {
    return new TextStyle(
      fontSize: 16.0 ,
    );
  }
  static TextStyle getItalicStyle() {
    return new TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w100,
    );
  }
  static TextStyle getBoldStyle() {
    return new TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    );
  }
}
