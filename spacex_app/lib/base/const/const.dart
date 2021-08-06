import 'package:flutter/material.dart';

const String url = "https://api.spacexdata.com/v4/launches/latest";

class ScreenSize {
  static width(double p, BuildContext context) {
    return MediaQuery.of(context).size.width * (p / 10);
  }

  static height(double p, BuildContext context) {
    return MediaQuery.of(context).size.height * (p / 10);
  }
}
