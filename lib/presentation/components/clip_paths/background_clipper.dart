
import 'package:flutter/material.dart';

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var roundnessFactor = 50.0;

    var path = Path();

    path.moveTo(roundnessFactor, 0);
    path.lineTo(size.width - roundnessFactor, 0);
    path.quadraticBezierTo(size.width , 0,size.width, roundnessFactor);
    path.lineTo(size.width, size.height-roundnessFactor*1.65);
    path.quadraticBezierTo(size.width,size.height+5,size.width-roundnessFactor*1.1, size.height);
    path.lineTo(roundnessFactor/2, size.height * .8);
    path.quadraticBezierTo(0,size.height*.8-roundnessFactor/4,0, size.height * .8-(roundnessFactor/2));
    path.lineTo(0, roundnessFactor);
    path.quadraticBezierTo(0,0,roundnessFactor, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
