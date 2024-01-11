import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// weather section widget
class WeatherSection extends StatelessWidget {
  ///constructor
  const WeatherSection({
    required this.iconpath,
    required this.title,
    required this.value,
    this.valueUnit,
    super.key,
  });

  /// assets path
  final String iconpath;

  /// titile of section
  final String title;

  /// value in section
  final num value;

  /// value unit
  final String? valueUnit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      width: 100.w,
      margin: const EdgeInsets.all(10),
      child: Center(
        child: Column(
          children: [
            Image.asset(
              iconpath,
              height: 35.h,
              fit: BoxFit.contain,
              color: Colors.white60,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              '$value${valueUnit ?? ''}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
