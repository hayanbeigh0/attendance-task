import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/styles.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Divider(
          color: AppColors.defaultGrey,
          height: 5,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.appWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 12)),
            onPressed: onPressed,
            child: Text(
              text,
              style: AppStyles.appBar.copyWith(
                color: AppColors.appWhite,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
