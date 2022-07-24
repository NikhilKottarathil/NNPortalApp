import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

const PrimaryColor = Color(0xff181818);
const PrimaryColorDark = Color(0xff121212);
const PrimaryColorLight = Color(0xff282828);
const PrimaryColorLighter = Color(0xff3A3B3C);
const PrimaryColorLightest = Color(0xff404040);

class ShimmerCircle extends StatelessWidget {
  final double radius;

  ShimmerCircle({required this.radius});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      enabled: true,
      highlightColor: Colors.white,
      loop: 3,
      child: ClipOval(
        child: ColoredBox(
          color: Colors.white,
          child: SizedBox(
            height: radius * 2,
            width: radius * 2,
          ),
        ),
      ),
    );
  }
}

class ShimmerRectangle extends StatelessWidget {
  final double height, width;

   ShimmerRectangle({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: PrimaryColorLightest,
      highlightColor: PrimaryColorLighter,
      loop: 100,
      child: ColoredBox(
        color: PrimaryColor,
        child: SizedBox(
          height: height,
          width: width ,
        ),
      ),
    );
  }
}
