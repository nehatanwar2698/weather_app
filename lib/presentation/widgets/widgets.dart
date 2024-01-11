import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/utilities/app_colors.dart';

/// normal text
class NormalText extends StatelessWidget {
  ///constructor
  const NormalText(this.text, {super.key});

  /// text
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.foregroundColor,
      ),
    );
  }
}

/// bold text
class BoldText extends StatelessWidget {
  ///constructor
  const BoldText(this.text, {super.key});

  /// text
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.foregroundColor,
      ),
    );
  }
}

