import 'package:flutter/material.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:movixer/bloc/search_movie_page_bloc.dart';
import 'package:movixer/constant/colors.dart';
import 'package:movixer/constant/dimensions.dart';
import 'package:movixer/constant/images.dart';
import 'package:movixer/constant/strings.dart';
import 'package:movixer/data/model/movixer_hive_model.dart';
import 'package:movixer/data/vos/movie_vos/movie_vo.dart';
import 'package:movixer/pages/movie_detail_page.dart';
import 'package:provider/provider.dart';

final MovixerHiveModel movixerHiveModel = MovixerHiveModel();
final Debouncer debouncer = Debouncer();
const duration = Duration(milliseconds: 250);

class SearchMoviePage extends StatelessWidget {
  const SearchMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchMoviePageBloc>(
      create: (context) => SearchMoviePageBloc(),
      child: SafeArea(
          child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: kSecondaryColor,
              )),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [SearchBarSessionView(), SearchMovieListSessionView()],
          ),
        ),
      )),
    );
  }
}

//
//Search Bar Session
//

class SearchBarSessionView extends StatelessWidget {
  const SearchBarSessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSP20x, vertical: kSP20x),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: kSP20x),
            width: kSearchTextFieldWidth,
            height: kSearchTextFieldHeight,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(kSP20x)),
                color: kSearchBarColor),
            child: TextField(
              decoration: InputDecoration(
                  hintText: kSearchBarText,
                  hintStyle: TextStyle(color: kWhiteColor),
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none)),
              style: TextStyle(color: kWhiteColor),
              onChanged: (value) {
                debouncer.debounce(
                  duration: duration,
                  onDebounce: () {
                    movixerHiveModel.saveSearchQuery(value);
                    final bloc = context.read<SearchMoviePageBloc>();
                    bloc.callSearchMovies();
                  },
                );
              },
            ),
          ),
          Container(
            width: kSearchIconContainerSquareLength,
            height: kSearchIconContainerSquareLength,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(kSP10x)),
              color: kSecondaryColor,
            ),
            child: Center(
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: kWhiteColor,
                  )),
            ),
          )
        ],
      ),
    );
  }
}

//
//Searched Movie List View Session
//

class SearchMovieListSessionView extends StatelessWidget {
  const SearchMovieListSessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<SearchMoviePageBloc, List<MovieVO>>(
      builder: (_, searchMovieList, __) {
        if (searchMovieList.isEmpty) {
          return const Center(child: const SizedBox());
        }
        return Container(
          margin: EdgeInsets.symmetric(horizontal: kSP20x),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.72,
          child: ListView.separated(
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    movixerHiveModel.saveMovieID(searchMovieList[index].id);
                    Navigator.push(
                        _,
                        MaterialPageRoute(
                          builder: (_) => const MovieDetailPage(),
                        ));
                  },
                  child: SearchMovieTileView(movies: searchMovieList[index])),
              separatorBuilder: (context, index) => const SizedBox(
                    height: kSP20x,
                  ),
              itemCount: searchMovieList.length),
        );
      },
      selector: (_, bloc) => bloc.searchMovieList,
    );
  }
}

class SearchMovieTileView extends StatelessWidget {
  const SearchMovieTileView({super.key, required this.movies});

  final MovieVO? movies;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.9,
      height: kSearchMovieTileHeight,
      color: kSearchBarColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: kSearchMovieTileImageWidth,
            height: kSearchMovieTileImageHeight,
            child: Image.network("$kNetworkImageURLPrefix${movies?.posterPath}",
                fit: BoxFit.cover),
          ),
          SizedBox(
            width: kSearchMovieTitleWidth,
            child: Text(
              movies?.title ?? '',
              style: TextStyle(color: kWhiteColor),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: kSP10x),
            width: kSearchMovieTileYearBoxWidth,
            height: kSearchMovieTileYearBoxHeight,
            decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.circular(kSP5x)),
            child: Center(
              child: Text(
                movies?.popularity.toString() ?? '',
                style: TextStyle(color: kWhiteColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
