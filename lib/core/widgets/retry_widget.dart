import 'package:basigo_dirt/config/assets/app.images.dart';
import 'package:basigo_dirt/core/utils/size.util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RetryWidget extends StatelessWidget {
  final String? message;
  final void Function()? onRetry;
  final double topMargin;

  const RetryWidget({
    super.key,
    this.message,
    this.onRetry,
    this.topMargin = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: topMargin),
        child: Column(
          children: [
            Image.asset(AppImages.error, height: 180),
            20.h,
            Text(
              message ?? 'Something went wrong, Kindly Retry',
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyMedium,
            ),
            20.h,
            ElevatedButton(
              onPressed: onRetry,
              child: Text(
                'Retry',
                style: Get.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
