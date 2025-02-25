import 'package:basigo_dirt/core/utils/size.util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoIncidentsPlaceholder extends StatelessWidget {
  const NoIncidentsPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 150),
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
            'No Incidents Yet',
            style: Get.textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
