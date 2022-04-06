import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/base_model.dart';
import '../models/user_model.dart';
import 'app_preferences.dart';
import 'constants.dart';

void showToast(String content) {
  Fluttertoast.showToast(
      msg: content,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(0.6),
      textColor: Colors.white,
      fontSize: 16.0);
}

// Future<bool> connectivityCheck() async {
//   bool connect = false;
//
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.mobile) {
//     // I am connected to a mobile network.
//     connect = true;
//     return connect;
//   } else if (connectivityResult == ConnectivityResult.wifi) {
//     // I am connected to a wifi network.
//     connect = true;
//     return connect;
//   } else {
//     return connect;
//   }
// }
// Future<void> openMap(double originLatitude, double originLongitude,double destLatitude, double destLongitude) async {
//   String origin = '${originLatitude},${originLongitude}';
//   String destination = '${destLatitude},${destLongitude}';
//   String googleUrl =
//       "https://www.google.com/maps/dir/?api=1&origin=" + origin + "&destination=" + destination + "&travelmode=driving&dir_action=navigate";
//   if (await canLaunch(googleUrl)) {
//     await launch(googleUrl);
//   }
// }

// List<LatLng> decodePolyline(String encoded) {
//   List<LatLng> points = [];
//   int index = 0, len = encoded.length;
//   int lat = 0, lng = 0;
//   while (index < len) {
//     int b, shift = 0, result = 0;
//     do {
//       b = encoded.codeUnitAt(index++) - 63;
//       result |= (b & 0x1f) << shift;
//       shift += 5;
//     } while (b >= 0x20);
//     int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//     lat += dlat;
//     shift = 0;
//     result = 0;
//     do {
//       b = encoded.codeUnitAt(index++) - 63;
//       result |= (b & 0x1f) << shift;
//       shift += 5;
//     } while (b >= 0x20);
//     int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//     lng += dlng;
//     LatLng p = new LatLng(lat / 1E5, lng / 1E5);
//     points.add(p);
//   }
//   return points;
// }

bool isNotEmpty(value) {
  if (value != null && value != '') {
    return true;
  }
  return false;
}

bool isEmpty(value) {
  if (value == null || value == '') {
    return true;
  }
  return false;
}

verticalSpace({height = 10}) {
  return SizedBox(
    height: (height as int).toDouble(),
  );
}

horizontalSpace({width = 10}) {
  return SizedBox(
    width: (width as int).toDouble(),
  );
}

String formatHHMMSS(int seconds) {
  if (seconds != null && seconds != 0) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "${hoursStr}h:${minutesStr}m:${secondsStr}s";
  } else {
    return "00h:00m:00s";
  }
}

String formatDate(DateTime date, {format = "dd-MM-yyyy'T'HH:mm:ss"}) {
  return DateFormat(format).format(date);
}

DateTime parseDate(String date, {String format = "dd-MM-yyyy'T'HH:mm:ss"}) {
  return DateFormat(format).parse(date);
}

void navigateUserToPage(BaseModel baseModel,
    {route = NamedRoutes.routeMain,
    navigationType = 'push_on_stack',
    arguments}) {
  var user = UserModel.fromMap(baseModel.data);
  globalPreferences?.setString(AppPreferences.TOKEN, user.token!);
  globalPreferences?.setString(
      AppPreferences.USER_MODEL, jsonEncode(user.toJson()));
  if (navigationType == 'push_on_stack') {
    Get.toNamed(route, arguments: arguments);
  } else if (navigationType ==
      'push_current_on_stack_and_pop_all_previous_route') {
    Get.offNamedUntil(route, (route) => false, arguments: arguments);
  }
}

void logoutUser() {
  globalPreferences?.setString(AppPreferences.TOKEN, "");
  globalPreferences?.setString(AppPreferences.USER_MODEL, "");
  Get.offNamedUntil(NamedRoutes.routeSignUp, (route) => false);
}
