// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:movixer/bloc/home_page_bloc.dart';

import 'package:movixer/constant/colors.dart';
import 'package:movixer/constant/dimensions.dart';
import 'package:movixer/constant/images.dart';
import 'package:movixer/constant/strings.dart';

import 'package:movixer/data/model/movixer_hive_model.dart';
import 'package:movixer/data/vos/actor_vos/actor_vo.dart';

import 'package:movixer/data/vos/genres_vos/genres_vos.dart';
import 'package:movixer/data/vos/movie_video_vos/movie_video_vo.dart';
import 'package:movixer/data/vos/movie_vos/movie_vo.dart';
import 'package:movixer/pages/actor_detail_page.dart';
import 'package:movixer/pages/movie_detail_page.dart';
import 'package:movixer/pages/search_movie_page.dart';
import 'package:movixer/widgets/movie_info_view_widget.dart';
import 'package:movixer/widgets/movie_slider_item_view_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

final MovixerHiveModel movixerHiveModel = MovixerHiveModel();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
      create: (context) => HomePageBloc(),
      child: const SafeArea(
        child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SearchBarSessionView(),
                  NavigationBarSessionView(),
                  MovieSliderSessionView(),
                  MoviesByGenreSliderSessionView(),
                  TitleSessionView(title: kSimilarMovieSessionTitleText),
                  TopRatedMovieSliderSessionView(),
                  TitleSessionView(title: kPopularMovieSessionTitleText),
                  PopularMoviesSliderSessionView(),
                  ActorSliderSessionView()
                ],
              ),
            )),
      ),
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
      padding: const EdgeInsets.only(left: kSP20x, right: kSP20x, top: kSP35x),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchMoviePage(),
                  ));
            },
            child: Container(
                padding: const EdgeInsets.only(
                    left: kSP20x, right: kSP20x, top: kSP17x),
                width: kSearchTextFieldWidth,
                height: kSearchTextFieldHeight,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(kSP20x)),
                    color: kSearchBarColor),
                child: Text(
                  kSearchBarText,
                  style: TextStyle(color: kWhiteColor),
                )),
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SearchMoviePage(),
                        ));
                  },
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
//Navigation Bar Session
//

class NavigationBarSessionView extends StatefulWidget {
  const NavigationBarSessionView({super.key});

  @override
  State<NavigationBarSessionView> createState() =>
      _NavigationBarSessionViewState();
}

class _NavigationBarSessionViewState extends State<NavigationBarSessionView> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, List<GenresVO>>(
      builder: (_, genreList, __) {
        if (genreList.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: kSP25x),
            child: const Center(
              child: CircularProgressIndicator(
                color: kSecondaryColor,
              ),
            ),
          );
        }
        return Padding(
          padding:
              const EdgeInsets.only(top: kSP20x, bottom: kSP20x, left: kSP15x),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.93,
            height: kNavigationBarItemHeight,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      movixerHiveModel.saveGenreID(genreList[index].id);
                      if (mounted) {
                        setState(() {
                          currentIndex = index;
                        });
                      }
                      final bloc = context.read<HomePageBloc>();
                      bloc.callMoviesByGenreApi();
                    },
                    child: NavigationBarItemView(
                      genres: genreList[index],
                      color: currentIndex == index
                          ? kSecondaryColor
                          : kPrimaryColor,
                    )),
                separatorBuilder: (context, index) => const SizedBox(
                      width: kSP15x,
                    ),
                itemCount: genreList.length),
          ),
        );
      },
      selector: (_, bloc) => bloc.genresList,
    );
  }
}

class NavigationBarItemView extends StatelessWidget {
  const NavigationBarItemView({
    super.key,
    required this.color,
    required this.genres,
  });

  final Color color;
  final GenresVO? genres;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: kNavigationBarItemWidth,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(kSP10x)),
      child: Center(
          child: Text(
        genres?.name ?? '',
        style: const TextStyle(color: kWhiteColor),
      )),
    );
  }
}

//
//Main movie slider session
//

class MovieSliderSessionView extends StatelessWidget {
  const MovieSliderSessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, List<MovieVO>>(
      builder: (_, movieList, __) {
        if (movieList.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: kSP350x),
            child: const Center(
              child: CircularProgressIndicator(
                color: kSecondaryColor,
              ),
            ),
          );
        }

        return CarouselSlider.builder(
            itemCount: 5,
            itemBuilder: (context, index, realIndex) => SliderSessionItemView(
                  movies: movieList[index],
                  movieID: movieList[index].id,
                ),
            options: CarouselOptions(
              aspectRatio: 2.1 / 2,
              viewportFraction: 0.7,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ));
      },
      selector: (_, bloc) => bloc.moviesByGenresList,
    );
  }
}

class SliderSessionItemView extends StatelessWidget {
  const SliderSessionItemView({
    super.key,
    required this.movies,
    required this.movieID,
  });

  final MovieVO? movies;
  final int movieID;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: kSliderItemWidth,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(kSP25x))),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(kSP25x)),
          child: Image.network("$kNetworkImageURLPrefix${movies?.posterPath}",
              fit: BoxFit.cover),
        ),
      ),
      Container(
        width: kSliderItemWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(kSP25x)),
          gradient: const LinearGradient(
            colors: [Colors.transparent, Colors.transparent, kPrimaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      Center(
        child: Container(
          width: kPlayIconSquareLength,
          height: kPlayIconSquareLength,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(kSP40x),
              ),
              color: kSecondaryColor),
          child: IconButton(
              onPressed: () {
                movixerHiveModel.saveMovieID(movieID);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.all(kSP5x),
                      backgroundColor: kPrimaryColor,
                      content:
                          VideoDiaLogItemView(movieTitle: movies?.title ?? ''),
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.play_arrow,
                color: kWhiteColor,
              )),
        ),
      )
    ]);
  }
}

//
//You Tube Video Dialog
//

class VideoDiaLogItemView extends StatelessWidget {
  const VideoDiaLogItemView({super.key, required this.movieTitle});

  final String movieTitle;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
      create: (context) => HomePageBloc(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: kSP15x, horizontal: kSP15x),
              child: Text(
                movieTitle,
                style: TextStyle(
                    color: kWhiteColor,
                    fontSize: kFontSize20x,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(
              thickness: 2,
              color: kWhiteColor,
              endIndent: kSP15x,
            ),
            const SizedBox(
              height: kSP20x,
            ),
            VideoListSessionView()
          ],
        ),
      ),
    );
  }
}

//
//Video type list session
//

class VideoListSessionView extends StatefulWidget {
  const VideoListSessionView({super.key});

  @override
  State<VideoListSessionView> createState() => _VideoListSessionViewState();
}

class _VideoListSessionViewState extends State<VideoListSessionView> {
  @override
  void initState() {
    final bloc = context.read<HomePageBloc>();
    bloc.callMovieVideosApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, List<MovieVideoVO>>(
      builder: (context, videoList, __) {
        if (videoList.isEmpty) {
          return Center(
            child: CircularProgressIndicator(
              color: kSecondaryColor,
            ),
          );
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.93,
          height: MediaQuery.of(context).size.height * 0.2,
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () async {
                final url =
                    "https://www.youtube.com/watch?v=${videoList[index].key}";
                if (await canLaunch(url)) {
                  await launch(url,
                      forceSafariVC: true,
                      forceWebView: true,
                      enableJavaScript: true);
                }
              },
              child: Container(
                padding: EdgeInsets.all(kSP10x),
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kSP10x),
                    border: Border.all(color: kSecondaryColor)),
                child: Center(
                  child: Text(
                    videoList[index].name,
                    style: TextStyle(color: kWhiteColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: kSP15x,
            ),
            itemCount: videoList.length,
          ),
        );
      },
      selector: (_, bloc) => bloc.videoList,
    );
  }
}

//
//Movies by Genres Session
//

class MoviesByGenreSliderSessionView extends StatelessWidget {
  const MoviesByGenreSliderSessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, List<MovieVO>>(
      builder: (_, moviesList, __) {
        if (moviesList.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: kSP350x),
            child: const Center(
              child: CircularProgressIndicator(color: kSecondaryColor),
            ),
          );
        }
        return Padding(
          padding:
              const EdgeInsets.only(top: kSP20x, bottom: kSP20x, left: kSP15x),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.93,
            height: kMoviesByGenresItemSquareLength,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        movixerHiveModel.saveMovieID(moviesList[index].id);
                        Navigator.push(
                            _,
                            MaterialPageRoute(
                              builder: (_) => const MovieDetailPage(),
                            ));
                      },
                      child: SliderSessionMoviesByGenresItemView(
                          movies: moviesList[index]),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      width: kSP5x,
                    ),
                itemCount: moviesList.length),
          ),
        );
      },
      selector: (_, bloc) => bloc.moviesByGenresList,
    );
  }
}

class SliderSessionMoviesByGenresItemView extends StatelessWidget {
  const SliderSessionMoviesByGenresItemView({super.key, required this.movies});

  final MovieVO? movies;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: kMoviesByGenresItemSquareLength,
          height: kMoviesByGenresItemSquareLength,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(kSP25x))),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(kSP25x)),
            child: Image.network("$kNetworkImageURLPrefix${movies?.posterPath}",
                fit: BoxFit.cover),
          ),
        ),
        Container(
          width: kMoviesByGenresItemSquareLength,
          height: kMoviesByGenresItemSquareLength,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(kSP25x)),
            gradient: const LinearGradient(
              colors: [Colors.transparent, kPrimaryColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        MovieInfoViewWidget(
            title: movies?.title ?? '',
            popularity: movies?.popularity ?? 0.0,
            voteCount: movies?.voteCount ?? 0)
      ],
    );
  }
}

//
//Title Text Session
//

class TitleSessionView extends StatelessWidget {
  const TitleSessionView({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kSP25x, top: kSP30x),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
              color: kWhiteColor,
              fontWeight: FontWeight.bold,
              fontSize: kFontSize20x),
        ),
      ),
    );
  }
}

//
//Top Rated Movies (You May Like) Session
//

class TopRatedMovieSliderSessionView extends StatelessWidget {
  const TopRatedMovieSliderSessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, List<MovieVO>>(
      builder: (_, topRatedMoviesList, __) {
        if (topRatedMoviesList.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: kSP350x),
            child: const Center(
              child: CircularProgressIndicator(
                color: kSecondaryColor,
              ),
            ),
          );
        }
        return Padding(
          padding:
              const EdgeInsets.only(top: kSP20x, bottom: kSP20x, left: kSP15x),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.93,
            height: kMovieSliderItemHeight,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        movixerHiveModel
                            .saveMovieID(topRatedMoviesList[index].id);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MovieDetailPage(),
                            ));
                      },
                      child: TopRatedMovieSliderItemView(
                          movies: topRatedMoviesList[index]),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      width: kSP5x,
                    ),
                itemCount: topRatedMoviesList.length),
          ),
        );
      },
      selector: (_, bloc) => bloc.topRatedMovieList,
    );
  }
}

class TopRatedMovieSliderItemView extends StatelessWidget {
  const TopRatedMovieSliderItemView({super.key, required this.movies});

  final MovieVO? movies;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MovieSliderItemViewWidget(posterPath: movies?.posterPath ?? ''),
        MovieInfoViewWidget(
            title: movies?.title ?? '',
            popularity: movies?.popularity ?? 0.0,
            voteCount: movies?.voteCount ?? 0)
      ],
    );
  }
}

//
//Popular Movie Session
//

class PopularMoviesSliderSessionView extends StatelessWidget {
  const PopularMoviesSliderSessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, List<MovieVO>>(
      builder: (_, popularMoviesList, __) {
        if (popularMoviesList.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: kSP350x),
            child: const Center(
              child: CircularProgressIndicator(
                color: kSecondaryColor,
              ),
            ),
          );
        }
        return Padding(
          padding:
              const EdgeInsets.only(top: kSP20x, bottom: kSP50x, left: kSP15x),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.93,
            height: kMovieSliderItemHeight,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        movixerHiveModel
                            .saveMovieID(popularMoviesList[index].id);
                        Navigator.push(
                            _,
                            MaterialPageRoute(
                              builder: (_) => const MovieDetailPage(),
                            ));
                      },
                      child: PopularMovieSliderItemView(
                          movies: popularMoviesList[index]),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      width: kSP5x,
                    ),
                itemCount: popularMoviesList.length),
          ),
        );
      },
      selector: (_, bloc) => bloc.popularMoviesList,
    );
  }
}

class PopularMovieSliderItemView extends StatelessWidget {
  const PopularMovieSliderItemView({super.key, required this.movies});

  final MovieVO? movies;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MovieSliderItemViewWidget(posterPath: movies?.posterPath ?? ''),
        MovieInfoViewWidget(
            title: movies?.title ?? '',
            popularity: movies?.popularity ?? 0.0,
            voteCount: movies?.voteCount ?? 0)
      ],
    );
  }
}

//
//Actor Session
//

class ActorSliderSessionView extends StatelessWidget {
  const ActorSliderSessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, List<ActorVO>>(
      builder: (_, actorList, __) {
        if (actorList.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: kSP350x),
            child: const Center(
              child: CircularProgressIndicator(
                color: kSecondaryColor,
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: kSP20x),
          child: CarouselSlider.builder(
              itemCount: actorList.length,
              itemBuilder: (context, index, realIndex) => GestureDetector(
                  onTap: () {
                    movixerHiveModel.saveActorID(actorList[index].id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActorDetailPage(
                              knownFor: actorList[index].knownFor),
                        ));
                  },
                  child: ActorSliderSessionItemView(actor: actorList[index])),
              options: CarouselOptions(
                aspectRatio: 2.1 / 2,
                viewportFraction: 0.7,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: (index, reason) {},
                scrollDirection: Axis.horizontal,
              )),
        );
      },
      selector: (_, bloc) => bloc.actorList,
    );
  }
}

class ActorSliderSessionItemView extends StatelessWidget {
  const ActorSliderSessionItemView({super.key, required this.actor});

  final ActorVO? actor;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: kSliderItemWidth,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(kSP25x))),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(kSP25x)),
          child: Image.network("$kNetworkImageURLPrefix${actor?.profilePath}",
              fit: BoxFit.cover),
        ),
      ),
      Container(
        width: kSliderItemWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(kSP25x)),
          gradient: const LinearGradient(
            colors: [Colors.transparent, Colors.transparent, kPrimaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: kSP10x),
          child: Text(
            actor?.name ?? '',
            style: TextStyle(
                color: kWhiteColor,
                fontSize: kFontSize20x,
                fontWeight: FontWeight.bold),
          ),
        ),
      )
    ]);
  }
}
