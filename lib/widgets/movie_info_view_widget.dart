import 'package:flutter/material.dart';
import 'package:movixer/constant/colors.dart';
import 'package:movixer/constant/dimensions.dart';

class MovieInfoViewWidget extends StatelessWidget {
  const MovieInfoViewWidget(
      {super.key,
      required this.title,
      required this.popularity,
      required this.voteCount});

  final String title;
  final double popularity;
  final int voteCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSP10x),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.only(right: kSP30x),
            width: kMoviesByGenresItemSquareLength,
            child: Text(
              title,
              style: const TextStyle(
                  color: kWhiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: kFontSize18x),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: kSP10x,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.star_rate,
                color: kRatingStarColor,
              ),
              Text(
                popularity.toString(),
                style: const TextStyle(color: kWhiteColor),
              ),
              const SizedBox(
                width: kSP50x,
              ),
              Text(
                voteCount.toString(),
                style: const TextStyle(color: kWhiteColor),
              ),
            ],
          ),
          const SizedBox(
            height: kSP10x,
          ),
        ],
      ),
    );
  }
}
