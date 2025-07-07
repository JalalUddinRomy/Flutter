import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/image_path.dart';

class AppIconWidget extends StatelessWidget {
  const AppIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(ImagePath.logoImage);
  }
}