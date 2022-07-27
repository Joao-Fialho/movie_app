import 'package:flutter/material.dart';

import '../../../../../../core/app_colors.dart';
import '../../../../../../core/app_image.dart';

class FundoEmBreve extends StatefulWidget {
  const FundoEmBreve({Key? key}) : super(key: key);

  @override
  State<FundoEmBreve> createState() => _FundoEmBreveState();
}

class _FundoEmBreveState extends State<FundoEmBreve> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: Image.asset(
              AppImage.demonSlayerComingSoon,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: AppColors.transparentImageComingSoon,
          ),
        ],
      ),
    );
  }
}
