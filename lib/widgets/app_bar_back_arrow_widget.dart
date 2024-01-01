import 'package:flutter/material.dart';
import 'package:movixer/constant/colors.dart';
import 'package:movixer/constant/dimensions.dart';

class AppBarBackArrowWidget extends StatelessWidget {
  const AppBarBackArrowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: kSP15x, left: kSP15x),
      width: kAppBarButtonSquareLength,
      height: kAppBarButtonSquareLength,
      decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(kSP20x))),
      child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: kWhiteColor,
          )),
    );
  }
}
