import 'package:basigo_dirt/core/utils/size.util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoIncidentsPlaceholder extends StatelessWidget {
  final double topMargin;

  const NoIncidentsPlaceholder({
    super.key,
    this.topMargin = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topMargin),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image_search_outlined,
                color: Get.theme.primaryColor,
                size: 120,
              ),
            ],
          ),
          10.h,
          Text(
            'No Incidents Yet\nNew Incidents will be automatically updated here',
            textAlign: TextAlign.center,
            style: Get.textTheme.headlineSmall?.copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
