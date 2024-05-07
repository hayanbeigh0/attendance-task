import 'package:attendance/screens/face_scan.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/styles.dart';
import 'package:attendance/widgets/bottom_button.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/png/capture.png',
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.0),
                  child: Text(
                    'Initiate face verification for quick attendance Process.',
                    style: AppStyles.appBar,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Privacy Notice',
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomButton(
        onPressed: () async {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FaceScan(),
          ));
        },
        text: 'Verify',
      ),
    );
  }
}
