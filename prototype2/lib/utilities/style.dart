import 'package:flutter/material.dart';

class MyStyle {
  static TextStyle getStyle() {
    return new TextStyle(
      fontSize: 14.0 ,
    );
  }
  static TextStyle getItalicStyle() {
    return new TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w100,
    );
  }
  static TextStyle getBoldStyle() {
    return new TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    );
  }
  static TextStyle getHeaderStyle() {
    return new TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
    );
  }
}
