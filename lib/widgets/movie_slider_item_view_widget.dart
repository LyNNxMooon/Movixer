import 'package:flutter/material.dart';
import 'package:movixer/constant/colors.dart';
import 'package:movixer/constant/dimensions.dart';
import 'package:movixer/constant/images.dart';

class MovieSliderItemViewWidget extends StatelessWidget {
  const MovieSliderItemViewWidget({super.key, required this.posterPath});

  final String posterPath;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: kMovieSliderItemWidth,
          height: kMovieSliderItemHeight,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(kSP25x))),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(kSP25x)),
            child: Image.network("$kNetworkImageURLPrefix$posterPath",
                fit: BoxFit.cover),
          ),
        ),
        Container(
          width: kMovieSliderItemWidth,
          height: kMovieSliderItemGradientHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(kSP25x)),
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.transparent, kPrimaryColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}
