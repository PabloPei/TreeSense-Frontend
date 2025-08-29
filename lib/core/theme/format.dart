import 'package:flutter/material.dart';

const String dateFormatPattern = 'dd/MM/yyyy HH:mm';

//Entry type ID codes (corresponding with type table at db)
const String typeIdCodePlanter = 'P';
const String typeIdCodeTree = 'T';
const String typeIdCodePlanterTree = 'PT';

// Icon sizes
class AppIconSizes {
  static const double profile = 30;
}

//Field upper/lower bounds for validation
const int latitudeMin = -180;
const int latitudeMax = 180;
const int longitudeMin = -180;
const int longitudeMax = 180;
const int streetWidthMax = 8; //8m
const int planterLengthMax = 3; //3m
const int planterWidthMax = 3; //3m
const int heightMax = 30; //30m
const int stemPerimeterMax = 300; //300cm
const int stemInclinationMax = 90; //90°
const int photosMax = 5;
const int charactersMax = 500;

// Standard padding/margin
class AppSpacing {
  static const double xxs = 2.0;
  static const double xs = 8.0;
  static const double sm = 16.0;
  static const double md = 24.0;
  static const double lg = 32.0;
  static const double xl = 40.0;
  static const double xxl = 48.0;
  static const double xxxl = 56.0;
}

// Rounded edges
class AppBorderRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double full = 1000.0;
}

extension ScreenSizeExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}
