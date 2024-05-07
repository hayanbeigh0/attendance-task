import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FaceCapture extends StatelessWidget {
  const FaceCapture({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appWhite,
      appBar: AppBar(
        backgroundColor: AppColors.appWhite,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.chevron_left,
            color: AppColors.primary,
          ),
        ),
        title: const Text(
          'Face Verification',
          style: AppStyles.appBar,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/png/capture.png',
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
