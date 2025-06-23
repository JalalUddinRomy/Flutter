import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/imagepath.dart';

class screenBackground extends StatelessWidget {
  const screenBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size screen_size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        SvgPicture.asset(
          Imagepath.background_image,
          width: screen_size.width,
          height: screen_size.height,
          fit: BoxFit.cover,
        ),
        SafeArea(child: child),
      ],
    );
  }
}
