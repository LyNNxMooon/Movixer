import 'package:flutter/material.dart';
import 'package:movixer/data/model/movixer_model.dart';
import 'package:movixer/network/response/actor_detail_response/actor_detail_response.dart';

class ActorDetailPageBloc extends ChangeNotifier {
  bool isDispose = false;
  final MovixerModel _movixerModel = MovixerModel();
  ActorDetailResponse? actorDetailResponse;

  ActorDetailPageBloc() {
    _movixerModel.getActorDetails().then((value) {
      actorDetailResponse = value;
      notifyListeners();
    });
  }

  @override
  void notifyListeners() {
    if (!isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    isDispose = true;
    super.dispose();
  }
}
