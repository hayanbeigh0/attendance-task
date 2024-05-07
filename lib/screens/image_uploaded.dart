import 'dart:io';

import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/enums.dart';
import 'package:attendance/utils/styles.dart';
import 'package:attendance/widgets/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageUploaded extends StatelessWidget {
  const ImageUploaded(
      {super.key, required this.imageFile, required this.verificationStatus});
  final File imageFile;
  final VerificationStatus verificationStatus;
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 20),
                      child: Image.file(imageFile),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        if (verificationStatus == VerificationStatus.cvFailure || verificationStatus == VerificationStatus.inlFailure)
                          Column(
                            children: [
                              Text(
                                'We couldn\'t recognize your face',
                                style: AppStyles.appBar.copyWith(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: 150,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: AppColors.primary,
                                    ),
                                    foregroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/refresh.svg',
                                        color: AppColors.primary,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Expanded(
                                          child: Text(
                                        'Re-Take',
                                        textAlign: TextAlign.center,
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        if (verificationStatus == VerificationStatus.gthFailure)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 60.0),
                            child: Column(
                              children: [
                                Text(
                                  'We couldn\'t recognize your face',
                                  style:
                                      AppStyles.appBar.copyWith(fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Don’t Worry, your request for Attendance has been sent to the Head for approval!',
                                  style: AppStyles.appBar.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Go to Dashboard and continue with your tasks for the day once your attendance is approved.',
                                  style: AppStyles.appBar.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        if (verificationStatus == VerificationStatus.success)
                          Text(
                            'Face Verified Successfully',
                            style: AppStyles.appBar.copyWith(fontSize: 16),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomButton(
        onPressed: verificationStatus == VerificationStatus.cvFailure ||
                verificationStatus == VerificationStatus.inlFailure
            ? null
            : verificationStatus == VerificationStatus.gthFailure ||
                    verificationStatus == VerificationStatus.success
                ? () {}
                : null,
        text: verificationStatus == VerificationStatus.gthFailure
            ? 'Go to Dashboard'
            : 'Submit',
      ),
    );
  }
}
