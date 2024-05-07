import 'dart:io';

import 'package:attendance/logic/cubit/send_image_cubit.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/styles.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaceScan extends StatelessWidget {
  const FaceScan({super.key});

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
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SmartFaceCamera(
                      messageBuilder: (context, detectedFace) {
                        return const SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Please look into the camera and hold still',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                      indicatorBuilder: (context, detectedFace, imageSize) {
                        return Center(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Image.asset('assets/png/imageborder.png'),
                          ),
                        );
                      },
                      performanceMode: FaceDetectorMode.accurate,
                      showControls: false,
                      autoCapture: true,
                      defaultCameraLens: CameraLens.front,
                      message: 'Center your face in the square',
                      onCapture: (File? image) async {
                        if (image != null) {
                          final img = image;
                          BlocProvider.of<SendImageCubit>(context)
                              .sendImage(img);
                        }
                      },
                      onFaceDetected: (face) {},
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              right: 30,
              left: 30,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '48% Scanning',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(10),
                    minHeight: 8,
                    backgroundColor: AppColors.secondary,
                    color: AppColors.primary,
                    value: 0.5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
