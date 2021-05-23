import 'package:flutter/material.dart';

class SizeConfig {
  static double ekranGenisligi;
  static double ekranYuksekligi;
}

double yuksekligeGoreAyarla(BuildContext context, double inputHeight) {
  double ekranYuksekligi = MediaQuery.of(context).size.height;
  return (inputHeight / 812.0) * ekranYuksekligi;
}

double genisligeGoreAyarla(BuildContext context, double inputWidth) {
  double ekranGenisligi = MediaQuery.of(context).size.width;
  return (inputWidth / 375.0) * ekranGenisligi;
}
