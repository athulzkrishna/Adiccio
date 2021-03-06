import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skype_app/utils/universal_variables.dart';

class ShimmeringLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: Shimmer.fromColors(
        baseColor: UniversalVariables.greyColor,
        highlightColor: Colors.white,
        child: Image.asset("assets/liggs.png"),
        period: Duration(seconds: 1),
      ),
    );
  }
}
