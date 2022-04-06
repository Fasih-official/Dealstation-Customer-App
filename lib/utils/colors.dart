import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const appBarColor = Color(0xffFDE100);
const darkAppBarColor = Color(0xff34125B);
const normalTextAndButtonColor = Color(0xff34125b);
var darkGreyColor = const Color(0xff636A6B);
var lightGreyColor = const Color(0xff848484);
const lighterGreyColor = Color(0xffC1C6C8);
const lightestGreyColor = Color(0xffEDEDED);
const moreLighterGreyColor = Color(0xffF3F4F4);
var lightPurpleColor = const Color(0xffC1A7E2);
var sandColor = const Color(0xff9F4811);
var redColor = const Color(0xffFA4040);

var circularBoxColor = const Color(0xff9F9F9F);
var orangeColor = const Color(0xffE65627);
var textColor = const Color(0xff578BB6);
var darkBtnColor = const Color(0xff858585);
var greenColor = const Color(0xff6FC787);
var fieldColor = const Color(0xffF1F1F1);

const MaterialColor appBarColorSwatch = const MaterialColor(
  0xffFDE100,
  // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
  const <int, Color>{
    50: appBarColor, //10%
    100: appBarColor, //20%
    200: appBarColor, //30%
    300: appBarColor, //40%
    400: appBarColor, //50%
    500: appBarColor, //60%
    600: appBarColor, //70%
    700: appBarColor, //80%
    800: appBarColor, //90%
    900: appBarColor, //100%
  },
);