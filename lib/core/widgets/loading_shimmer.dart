import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  final int length;
  final double width;
  final EdgeInsetsGeometry? margin;

  const LoadingShimmer({
    super.key,
    this.length = 3,
    this.width = 100,
    this.margin = const EdgeInsets.only(top: 20),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: SingleChildScrollView(
        child: Column(
          children: List<Widget>.generate(
            length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TransactionShimmerCard(
                width: width,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionShimmerCard extends StatelessWidget {
  final double width;
  const TransactionShimmerCard({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerWidget.rectangular(
                  height: 15,
                  width: width,
                ),
                Container(
                  width: 100,
                  height: 15,
                  color: Colors.white,
                ),
                ShimmerWidget.rectangular(
                  height: 15,
                  width: width,
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 15,
              color: Colors.white,
            ),
            Column(
              children: List<Widget>.generate(
                6,
                (index) => Column(
                  children: [
                    const ShimmerWidget.rectangular(
                      height: 8,
                      width: double.infinity,
                    ),
                    Container(
                      width: double.infinity,
                      height: 4,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 15,
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 8,
                  height: 30,
                  color: Colors.white,
                ),
                ShimmerWidget.rectangular(
                  height: 30,
                  width: width,
                ),
                Container(
                  width: width,
                  height: 30,
                  color: Colors.white,
                ),
                ShimmerWidget.rectangular(
                  height: 30,
                  width: width,
                ),
                Container(
                  width: 8,
                  height: 30,
                  color: Colors.white,
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const RoundedRectangleBorder(),
  });

  const ShimmerWidget.circular({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Get.theme.primaryColor.withOpacity(0.2),
        highlightColor: Get.theme.scaffoldBackgroundColor,
        period: const Duration(milliseconds: 1400),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: shapeBorder,
          ),
        ),
      );
}
