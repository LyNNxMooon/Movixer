import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movixer/constant/colors.dart';
import 'package:movixer/constant/dimensions.dart';
import 'package:movixer/constant/strings.dart';
import 'package:movixer/data/model/movixer_hive_model.dart';
import 'package:movixer/pages/home_page.dart';
import 'package:movixer/persistent/hive_constant.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  await Hive.openBox<int>(kHiveGenreIDBox);
  await Hive.openBox<int>(kHiveMovieIDBox);
  await Hive.openBox<int>(kHiveActorIDBox);
  await Hive.openBox<String>(kHiveSearchQueryBox);
  final MovixerHiveModel movixerHiveModel = MovixerHiveModel();
  movixerHiveModel.removeGenreID();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
          duration: 2500,
          splash: const Center(
            child: Text(
              kMovixerText,
              style: TextStyle(
                  color: kSecondaryColor,
                  fontWeight: FontWeight.w100,
                  fontSize: kSP50x),
            ),
          ),
          nextScreen: const HomePage(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
          backgroundColor: kPrimaryColor),
      debugShowCheckedModeBanner: false,
    );
  }
}
