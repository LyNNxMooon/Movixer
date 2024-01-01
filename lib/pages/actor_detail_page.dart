import 'package:flutter/material.dart';
import 'package:movixer/bloc/actor_detail_page_bloc.dart';
import 'package:movixer/constant/colors.dart';
import 'package:movixer/constant/dimensions.dart';
import 'package:movixer/constant/images.dart';
import 'package:movixer/constant/strings.dart';
import 'package:movixer/data/vos/actor_vos/actor_known_for_vo.dart';

import 'package:movixer/pages/movie_detail_page.dart';
import 'package:movixer/widgets/app_bar_back_arrow_widget.dart';
import 'package:movixer/widgets/movie_info_view_widget.dart';
import 'package:movixer/widgets/movie_slider_item_view_widget.dart';
import 'package:provider/provider.dart';

class ActorDetailPage extends StatelessWidget {
  const ActorDetailPage({
    super.key,
    required this.knownFor,
  });

  final List<ActorKnownForVO> knownFor;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ActorDetailPageBloc>(
      create: (context) => ActorDetailPageBloc(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Consumer<ActorDetailPageBloc>(
            builder: (_, bloc, __) {
              if (bloc.actorDetailResponse == null) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: kSecondaryColor,
                  ),
                );
              }
              return CustomScrollView(
                slivers: [
                  //
                  //App Bar Session
                  //

                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: kPrimaryColor,
                    expandedHeight: 500,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                        background: Stack(children: [
                          SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: Image.network(
                              "$kNetworkImageURLPrefix${bloc.actorDetailResponse?.profilePath}",
                              fit: BoxFit.cover,
                            ),
                          ),
                          AppBarBackArrowWidget()
                        ]),
                        title: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kSP10x),
                          child: Text(
                            bloc.actorDetailResponse?.name ?? '',
                            style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        centerTitle: true),
                    centerTitle: true,
                  ),
                  SliverToBoxAdapter(
                    child: BiographySessionView(
                        biography: bloc.actorDetailResponse?.biography ?? ''),
                  ),
                  SliverToBoxAdapter(
                    child: MoreInfoSessionView(
                        birthPlace:
                            bloc.actorDetailResponse?.placeOfBirth ?? '',
                        birthday: bloc.actorDetailResponse?.birthday ?? '',
                        deathday: bloc.actorDetailResponse?.deathday ?? '-',
                        gender: bloc.actorDetailResponse?.gender ?? 1,
                        popularity:
                            bloc.actorDetailResponse?.popularity ?? 0.0),
                  ),
                  SliverToBoxAdapter(
                    child: KnownForMovieSessionView(knownFor: knownFor),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

//
//Title Session
//

class TitleSessionView extends StatelessWidget {
  const TitleSessionView({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSP15x),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: kWhiteColor,
                fontSize: kFontSize23x,
                fontWeight: FontWeight.bold),
          ),
          const Divider(
            height: kSP25x,
            thickness: 2,
            color: kWhiteColor,
          )
        ],
      ),
    );
  }
}

//
//Biography Session
//

class BiographySessionView extends StatelessWidget {
  const BiographySessionView({super.key, required this.biography});

  final String biography;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: kSP40x, left: kSP15x, right: kSP15x, top: kSP50x),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleSessionView(title: kActorDetailPageBiographyTitleText),
          Text(
            biography,
            style: TextStyle(color: kWhiteColor),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}

//
//More Info Session
//

class MoreInfoSessionView extends StatelessWidget {
  const MoreInfoSessionView(
      {super.key,
      required this.birthPlace,
      required this.birthday,
      required this.deathday,
      required this.gender,
      required this.popularity});

  final String birthPlace;
  final String birthday;
  final String deathday;
  final int gender;
  final double popularity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kSP30x, left: kSP15x, right: kSP15x),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleSessionView(title: kActorDetailPageMoreInfoTitleText),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoreInfoSessionRowItemView(
                  info: birthPlace, infoName: kActorDetailBirthPlaceText),
              MoreInfoSessionRowItemView(
                info: birthday,
                infoName: kActorDetailBirthDayText,
              ),
              MoreInfoSessionRowItemView(
                  info: deathday, infoName: kActorDetailDeathDayText),
              MoreInfoSessionRowItemView(
                  info: gender == 1 ? "Female" : "Male",
                  infoName: kActorDetailGenderText),
              MoreInfoSessionRowItemView(
                  info: popularity.toString(),
                  infoName: kActorDetailPopularityText)
            ],
          )
        ],
      ),
    );
  }
}

class MoreInfoSessionRowItemView extends StatelessWidget {
  const MoreInfoSessionRowItemView(
      {super.key, required this.info, required this.infoName});

  final String info;
  final String infoName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kSP20x),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            infoName,
            style: TextStyle(color: kWhiteColor),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(info,
                style: TextStyle(color: kWhiteColor),
                textAlign: TextAlign.left),
          )
        ],
      ),
    );
  }
}

//
//Known For Movie Session
//

class KnownForMovieSessionView extends StatelessWidget {
  const KnownForMovieSessionView({super.key, required this.knownFor});

  final List<ActorKnownForVO> knownFor;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: kSP15x, right: kSP15x, bottom: kSP15x),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TitleSessionView(title: kActorDetailPageKnowForMoviesTitleText),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.93,
            height: kMovieSliderItemHeight,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        movixerHiveModel.saveMovieID(knownFor[index].id);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MovieDetailPage(),
                            ));
                      },
                      child: KnownForMovieItemView(movies: knownFor[index]),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      width: kSP5x,
                    ),
                itemCount: knownFor.length),
          ),
        ]));
  }
}

class KnownForMovieItemView extends StatelessWidget {
  const KnownForMovieItemView({super.key, required this.movies});
  final ActorKnownForVO movies;
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
