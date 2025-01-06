import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveHelper {
  static bool isTablet() => ScreenUtil().screenWidth >= 600;

  static double width(double value) => value.w;

  static double height(double value) => value.h;

  static double fontSize(double value) => value.sp;
}
