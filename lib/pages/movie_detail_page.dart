import 'package:flutter/material.dart';
import 'package:movixer/bloc/movie_detail_page_bloc.dart';
import 'package:movixer/constant/colors.dart';
import 'package:movixer/constant/dimensions.dart';
import 'package:movixer/constant/images.dart';
import 'package:movixer/constant/strings.dart';
import 'package:movixer/data/model/movixer_hive_model.dart';
import 'package:movixer/data/vos/credits_vos/cast_vo.dart';
import 'package:movixer/data/vos/credits_vos/crew_vo.dart';
import 'package:movixer/data/vos/movie_detail_vos/production_companies_vo.dart';
import 'package:movixer/data/vos/movie_vos/movie_vo.dart';

import 'package:movixer/widgets/app_bar_back_arrow_widget.dart';
import 'package:movixer/widgets/cast_and_crew_tile_widget.dart';
import 'package:movixer/widgets/movie_info_view_widget.dart';
import 'package:movixer/widgets/movie_slider_item_view_widget.dart';
import 'package:provider/provider.dart';

final MovixerHiveModel movixerHiveModel = MovixerHiveModel();

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieDetailPageBloc>(
      create: (context) => MovieDetailPageBloc(),
      child: SafeArea(
          child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: CustomScrollView(
          slivers: [
            //
            //AppBar Session
            //
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              expandedHeight: 400,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Selector<MovieDetailPageBloc, String>(
                  builder: (_, moviePoster, __) {
                    if (moviePoster.isEmpty) {
                      return const SizedBox();
                    }
                    return Stack(children: [
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.network(
                          "$kNetworkImageURLPrefix${moviePoster}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      AppBarBackArrowWidget()
                    ]);
                  },
                  selector: (_, bloc) => bloc.moviePoster,
                ),
                title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kSP10x),
                    child: Selector<MovieDetailPageBloc, String>(
                      builder: (_, movieTitle, __) {
                        if (movieTitle.isEmpty) {
                          return const SizedBox();
                        }
                        return Text(
                          movieTitle,
                          style: TextStyle(
                              color: kWhiteColor, fontWeight: FontWeight.bold),
                        );
                      },
                      selector: (_, bloc) => bloc.movieTitle,
                    )),
                centerTitle: true,
              ),
            ),
            SliverToBoxAdapter(
              child: StoryLineSessionView(),
            ),
            SliverToBoxAdapter(
              child: CastSessionView(),
            ),
            SliverToBoxAdapter(
              child: CrewSessionView(),
            ),
            SliverToBoxAdapter(
              child: ProductionCompanySession(),
            ),
            SliverToBoxAdapter(
              child: RecommendedMovieSessionView(),
            )
          ],
        ),
      )),
    );
  }
}

//
//Title Text Session
//

class TitleTextSession extends StatelessWidget {
  const TitleTextSession({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSP25x),
      child: Text(
        title,
        style: TextStyle(
            color: kWhiteColor,
            fontSize: kFontSize25x,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

//
//Story Line Session
//

class StoryLineSessionView extends StatelessWidget {
  const StoryLineSessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<MovieDetailPageBloc, String>(
      builder: (_, movieOverview, __) {
        if (movieOverview.isEmpty) {
          return const SizedBox();
        }
        return Container(
          margin: EdgeInsets.symmetric(vertical: kSP30x, horizontal: kSP15x),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleTextSession(title: kMovieDetailPageStoryLineText),
              Text(
                movieOverview,
                style: TextStyle(color: kWhiteColor),
                textAlign: TextAlign.justify,
              )
            ],
          ),
        );
      },
      selector: (_, bloc) => bloc.movieOverview,
    );
  }
}

//
//Cast Session
//

class CastSessionView extends StatelessWidget {
  const CastSessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<MovieDetailPageBloc, List<CastVO>>(
      builder: (_, castList, __) {
        if (castList.isEmpty) {
          return const SizedBox();
        }
        return Container(
            margin: EdgeInsets.symmetric(horizontal: kSP15x),
            width: double.infinity,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TitleTextSession(title: kMovieDetailPageCastText),
              SizedBox(
                height: kCastAndCrewProfileImageBoxSquareLength,
                width: MediaQuery.of(context).size.width * 1,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => CastAndCrewTile(
                        profilePath: castList[index].profilePath ?? '',
                        department: castList[index].knownForDepartment,
                        name: castList[index].name),
                    separatorBuilder: (context, index) => const SizedBox(
                          width: kSP20x,
                        ),
                    itemCount: castList.length),
              )
            ]));
      },
      selector: (_, bloc) => bloc.castList,
    );
  }
}

//
//Crew Session
//

class CrewSessionView extends StatelessWidget {
  const CrewSessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<MovieDetailPageBloc, List<CrewVO>>(
      builder: (_, crewList, __) {
        if (crewList.isEmpty) {
          return const SizedBox();
        }
        return Container(
            margin: EdgeInsets.symmetric(horizontal: kSP15x, vertical: kSP30x),
            width: double.infinity,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TitleTextSession(title: kMovieDetailPageCrewText),
              SizedBox(
                height: kCastAndCrewProfileImageBoxSquareLength,
                width: MediaQuery.of(context).size.width * 1,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => CastAndCrewTile(
                        profilePath: crewList[index].profilePath ?? '',
                        department: crewList[index].knownForDepartment,
                        name: crewList[index].name),
                    separatorBuilder: (context, index) => const SizedBox(
                          width: kSP20x,
                        ),
                    itemCount: crewList.length),
              )
            ]));
      },
      selector: (_, bloc) => bloc.crewList,
    );
  }
}

//
//Production Company Session
//

class ProductionCompanySession extends StatelessWidget {
  const ProductionCompanySession({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<MovieDetailPageBloc, List<ProductionCompanyVO>>(
      builder: (_, companyList, __) {
        if (companyList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
              color: kSecondaryColor,
            ),
          );
        }
        return Container(
            margin: EdgeInsets.symmetric(horizontal: kSP15x),
            width: double.infinity,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TitleTextSession(
                  title: kMovieDetailPageProductionCompanyTitleText),
              SizedBox(
                height: kCompanyTileHeight,
                width: MediaQuery.of(context).size.width * 1,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ProductionCompanyTile(
                        profile: companyList[index].logoPath ??
                            '$kNullSafetyImagePath',
                        name: companyList[index].name),
                    separatorBuilder: (context, index) => const SizedBox(
                          width: kSP20x,
                        ),
                    itemCount: companyList.length),
              )
            ]));
      },
      selector: (_, bloc) => bloc.productionCompanyList,
    );
  }
}

class ProductionCompanyTile extends StatelessWidget {
  const ProductionCompanyTile(
      {super.key, required this.profile, required this.name});

  final String profile;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: kCompanyProfileImageSquareLength,
          height: kCompanyProfileImageSquareLength,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(kSP35x)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(kSP35x),
            child: Image.network("$kNetworkImageURLPrefix$profile"),
          ),
        ),
        const SizedBox(
          height: kSP20x,
        ),
        Text(
          textAlign: TextAlign.center,
          name,
          style: TextStyle(color: kWhiteColor),
        )
      ],
    );
  }
}

//
//Recommended movie session
//

class RecommendedMovieSessionView extends StatelessWidget {
  const RecommendedMovieSessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<MovieDetailPageBloc, List<MovieVO>>(
      builder: (_, similarMovieList, __) {
        if (similarMovieList.isEmpty) {
          return const SizedBox();
        }
        return Container(
            margin: EdgeInsets.only(left: kSP15x, right: kSP15x, top: kSP50x),
            width: double.infinity,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TitleTextSession(
                  title: kMovieDetailPageRecommendedSessionTitleText),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.93,
                height: kMovieSliderItemHeight,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            movixerHiveModel
                                .saveMovieID(similarMovieList[index].id);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MovieDetailPage(),
                                ));
                          },
                          child: RecommendedMovieSliderItemView(
                              movies: similarMovieList[index]),
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          width: kSP5x,
                        ),
                    itemCount: similarMovieList.length),
              ),
            ]));
      },
      selector: (_, bloc) => bloc.similarMovieList,
    );
  }
}

class RecommendedMovieSliderItemView extends StatelessWidget {
  const RecommendedMovieSliderItemView({super.key, required this.movies});

  final MovieVO movies;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MovieSliderItemViewWidget(posterPath: movies.posterPath ?? ''),
        MovieInfoViewWidget(
            title: movies.title ?? '',
            popularity: movies.popularity,
            voteCount: movies.voteCount)
      ],
    );
  }
}
