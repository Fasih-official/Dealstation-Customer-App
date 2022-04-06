import 'package:flutter/material.dart';

//Regular Text Styles
regularWhiteText8(color) => TextStyle(
      fontSize: 8,
      color: color,
      fontWeight: FontWeight.normal,
    );

regularWhiteText10(color) => TextStyle(
      fontSize: 10,
      color: color,
      fontWeight: FontWeight.normal,
    );

regularWhiteText12(color,{overflow}) => TextStyle(
      fontSize: 12,
      color: color,
      fontWeight: FontWeight.normal,
      overflow: overflow,
    );

regularWhiteText14(color) => TextStyle(
      fontSize: 14,
      color: color,
      fontWeight: FontWeight.normal,
      overflow: TextOverflow.ellipsis,
    );

regularWhiteTextWithDecoration14(color) => TextStyle(
      decoration: TextDecoration.underline,
      fontSize: 14,
      color: color,
      fontWeight: FontWeight.normal,
    );

regularWhiteText16(color) => TextStyle(
      fontSize: 16,
      color: color,
      fontWeight: FontWeight.normal,
    );

regularWhiteText18(color) => TextStyle(
      fontSize: 18,
      color: color,
      fontWeight: FontWeight.normal,
    );

regularWhiteText22(color) => TextStyle(
      fontSize: 22,
      color: color,
      fontWeight: FontWeight.normal,
    );

regularWhiteText24(color) => TextStyle(
      fontSize: 24,
      color: color,
      fontWeight: FontWeight.normal,
    );

//Bold Text Styles
boldWhiteText8(color) => TextStyle(
      fontSize: 8,
      color: color,
      fontWeight: FontWeight.bold,
    );

boldWhiteText10(color) => TextStyle(
      fontSize: 10,
      color: color,
      fontWeight: FontWeight.bold,
    );

boldWhiteText12(color) => TextStyle(
      fontSize: 12,
      color: color,
      fontWeight: FontWeight.bold,
    );

boldWhiteText14(color, {decoration}) => TextStyle(
    fontSize: 14,
    color: color,
    fontWeight: FontWeight.bold,
    decoration: decoration);

boldWhiteText16(color) => TextStyle(
      fontSize: 16,
      color: color,
      fontWeight: FontWeight.bold,
    );

boldWhiteText18(color, {height}) => TextStyle(
      fontSize: 18,
      color: color,
      height: height,
      fontWeight: FontWeight.bold,
    );

boldWhiteText32(color) => TextStyle(
      fontSize: 32, // default is 0.0
      color: color,
      fontWeight: FontWeight.bold,
    );

boldWhiteText28(color) => TextStyle(
      fontSize: 32, // default is 0.0
      color: color,
      fontWeight: FontWeight.bold,
    );

boldWhiteText24(color, {height}) => TextStyle(
      fontSize: 24,
      color: color,
      height: height,
      fontWeight: FontWeight.bold,
    );

boldWhiteText20(color, {height}) => TextStyle(
      fontSize: 20,
      color: color,
      height: height,
      fontWeight: FontWeight.bold,
    );
