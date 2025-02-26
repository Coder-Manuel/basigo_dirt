import 'package:basigo_dirt/core/enums/incident.enum.dart';
import 'package:basigo_dirt/core/utils/size.util.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident.entity.dart';
import 'package:basigo_dirt/modules/incident/presentation/widgets/incident_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ribbon_widget/ribbon_widget.dart';
import 'package:timeago/timeago.dart';

class IncidentItemCard extends StatelessWidget {
  final Incident incident;
  final bool canEdit;

  const IncidentItemCard({
    super.key,
    required this.incident,
    this.canEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: GestureDetector(
        onTap: () {
          if (canEdit) {
            Get.bottomSheet(
              IncidentActionSheet(incident: incident),
              backgroundColor: Colors.white,
              isScrollControlled: true,
            );
          }
        },
        child: Card(
          elevation: 1.5,
          surfaceTintColor: incident.status.isDone
              ? Colors.grey[700]
              : incident.severity.color.withOpacity(0.06),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Visibility(
            visible: incident.status.isDone,
            replacement: _ItemCard(incident: incident),
            child: Ribbon(
              farLength: 50,
              nearLength: 30,
              title: 'Closed',
              color: incident.status.color,
              location: RibbonLocation.topStart,
              titleStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              child: _ItemCard(incident: incident),
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({
    required this.incident,
  });

  final Incident incident;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: incident.status.isDone
                  ? Colors.grey[300]
                  : incident.severity.color.withOpacity(0.1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  incident.severity.icon,
                  color: incident.status.isDone
                      ? Colors.grey
                      : incident.severity.color,
                  size: 58,
                ),
                Text(
                  incident.severity.name,
                  style: Get.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          10.0.w,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        incident.title,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.titleMedium,
                      ),
                    ),
                    2.w,
                    Icon(
                      incident.isSynced
                          ? Icons.done_all_rounded
                          : Icons.done_rounded,
                      color: incident.isSynced
                          ? Get.theme.primaryColor
                          : Colors.orange,
                    )
                  ],
                ),
                15.0.h,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_on_rounded),
                    3.0.w,
                    Text(
                      incident.location.address,
                      style: Get.textTheme.bodySmall,
                    ),
                  ],
                ),
                20.0.h,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Status: ',
                        children: [
                          TextSpan(
                            text: incident.status.name,
                            style: Get.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: incident.status.color,
                            ),
                          ),
                        ],
                      ),
                      style: Get.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.timer_outlined, size: 15),
                        2.0.w,
                        Text(
                          format(incident.createdAt).replaceAll(
                            'minute',
                            'min',
                          ),
                          style: Get.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
