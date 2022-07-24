import 'package:flutter/material.dart';

List<BoxShadow> shadowSmall = [
  BoxShadow(
      color: Color(0xFF141414).withOpacity(.08),
      offset: Offset(0, 0),
      blurRadius: 8,
      spreadRadius: 0),
  BoxShadow(
      color: Color(0xFF141414).withOpacity(.04),
      offset: Offset(0, 0),
      blurRadius: 1,
      spreadRadius: 0),
];

List<BoxShadow> shadowMedium = [
  BoxShadow(
      color: Color(0xFF141414).withOpacity(.08),
      offset: Offset(0, 1),
      blurRadius: 8,
      spreadRadius: 2),
  BoxShadow(
      color: Color(0xFF141414).withOpacity(.08),
      offset: Offset(0, 0),
      blurRadius: 1,
      spreadRadius: 0),
];

List<BoxShadow> shadowLarge = [
  BoxShadow(
      color: Color(0xFF141414).withOpacity(.08),
      offset: Offset(0, 1),
      blurRadius: 24,
      spreadRadius: 8),
  BoxShadow(
      color: Color(0xFF141414).withOpacity(.08),
      offset: Offset(0, 0),
      blurRadius: 1,
      spreadRadius: 0),
];
