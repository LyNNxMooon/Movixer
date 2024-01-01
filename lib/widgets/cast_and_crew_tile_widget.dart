import 'package:flutter/material.dart';
import 'package:movixer/constant/colors.dart';
import 'package:movixer/constant/dimensions.dart';
import 'package:movixer/constant/images.dart';

class CastAndCrewTile extends StatelessWidget {
  const CastAndCrewTile(
      {super.key,
      required this.profilePath,
      required this.department,
      required this.name});
  final String profilePath;
  final String department;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: kCastAndCrewProfileImageBoxSquareLength,
          height: kCastAndCrewProfileImageBoxSquareLength,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(kSP35x)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(kSP35x),
              child: Image.network(
                "$kNetworkImageURLPrefix$profilePath",
                fit: BoxFit.cover,
              )),
        ),
        const SizedBox(
          width: kSP20x,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              department,
              style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
            ),
            Text(
              name,
              style: TextStyle(color: kWhiteColor),
            )
          ],
        )
      ],
    );
  }
}
