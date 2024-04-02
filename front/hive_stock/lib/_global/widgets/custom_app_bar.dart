import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_stock/_global/constants/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.smallOne, this.child});
  final bool smallOne;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
          SvgPicture.asset(CustomIcons.logo, height: smallOne ? 24 : 40,),
          const SizedBox(width: 5),
          Text("HiveStock", style: smallOne ? Theme.of(context).textTheme.titleMedium : Theme.of(context).textTheme.displaySmall,),
          if(child != null)
            const Spacer(),
          if(child != null) child!
        ],
    );
  }
}