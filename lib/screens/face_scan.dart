import 'dart:developer';
import 'dart:io';

import 'package:attendance/logic/cubit/send_image_cubit.dart';
import 'package:attendance/logic/progress_cubit/progress_cubit.dart';
import 'package:attendance/screens/image_uploaded.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/enums.dart';
import 'package:attendance/utils/styles.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaceScan extends StatefulWidget {
  FaceScan({super.key});

  @override
  State<FaceScan> createState() => _FaceScanState();
}

class _FaceScanState extends State<FaceScan> {
  double uploadProgress = 0.0;
  bool sendingImage = false;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      uploadProgress = 0.0;
    });
    BlocProvider.of<ProgressCubit>(context).sendProgress(0.0);
    super.initState();
  }

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
      body: BlocListener<SendImageCubit, SendImageState>(
        listener: (context, state) async {
          if (state is SendImageStarted) {
            // setState(() {
            //   sendingImage = true;
            // });
          }
          if (state is SendImageDone) {
            BlocProvider.of<ProgressCubit>(context).sendProgress(0.0);
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ImageUploaded(
                imageFile: state.imageFile!,
                verificationStatus: VerificationStatus.success,
              ),
            ));
            setState(() {
              uploadProgress = 0.0;
              sendingImage = false;
            });
          }
          if (state is SendImageFailed) {
            final messageCode;
            if (state.messageCode == 'CV') {
              messageCode = VerificationStatus.cvFailure;
            } else if (state.messageCode == 'INL') {
              messageCode = VerificationStatus.inlFailure;
            } else if (state.messageCode == 'GTH') {
              messageCode = VerificationStatus.gthFailure;
            } else {
              messageCode = VerificationStatus.cvFailure;
            }

            BlocProvider.of<ProgressCubit>(context).sendProgress(0.0);
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ImageUploaded(
                imageFile: state.imageFile!,
                verificationStatus: messageCode,
              ),
            ));
            setState(() {
              uploadProgress = 0.0;
              sendingImage = false;
            });
          }
          // TODO: implement listener
        },
        child: SizedBox(
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
                        performanceMode: FaceDetectorMode.fast,
                        showControls: false,
                        autoCapture: true,
                        defaultCameraLens: CameraLens.front,
                        message: 'Center your face in the square',
                        onCapture: (File? image) async {
                          if (image != null) {
                            final img = image;
                            if (!sendingImage) {
                              setState(() {
                                sendingImage = true;
                              });
                              BlocProvider.of<SendImageCubit>(context)
                                  .sendImage(context, img);
                            }
                            return;
                          }
                        },
                        onFaceDetected: (face) {
                          log('face detected');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<ProgressCubit, ProgressState>(
                builder: (context, state) {
                  if (state is ProgressUpdated) {
                    return Visibility(
                      visible: state.progress > 0,
                      replacement: const SizedBox(),
                      child: Positioned(
                        bottom: 20,
                        right: 30,
                        left: 30,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${(state.progress * 100).toInt()}% Scanning',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.defaultGrey,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            LinearProgressIndicator(
                              borderRadius: BorderRadius.circular(10),
                              minHeight: 8,
                              backgroundColor: AppColors.secondary,
                              color: AppColors.primary,
                              value: state.progress,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox(); // Hide the progress indicator if the state is not ProgressUpdated
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
