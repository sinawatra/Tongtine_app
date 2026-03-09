import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PngFixedSize extends StatelessWidget {
  final double width;
  final double height;
  final String path;
  final Color? color;
  const PngFixedSize({
    super.key,
    this.width = 24,
    this.height = 24,
    required this.path,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      height: height,
      width: width,
      filterQuality: FilterQuality.high,
      color: color,
    );
  }
}

class SvgFixedSize extends StatelessWidget {
  final double width;
  final double height;
  final String path;
  final Color? color;
  final bool colorBlendMode;
  const SvgFixedSize({
    super.key,
    this.width = 24,
    this.height = 24,
    required this.path,
    this.color,
    this.colorBlendMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: height,
      width: width,
      color: color,
      colorBlendMode: colorBlendMode ? BlendMode.color : BlendMode.srcIn,
    );
  }
}
