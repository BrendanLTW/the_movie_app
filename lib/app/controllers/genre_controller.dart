import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/movie_model.dart';
import '../data/provider/api/api.dart';

class GenreController extends GetxController with StateMixin<List<GenreModel>> {

  @override
  void onInit() {  
    super.onInit();
    loadGenreList();
  }

  loadGenreList() async {
    change([], status: RxStatus.loading());
    final Response response = await API(
      path: 'genre/movie/list'
    ).httpRequest();
    if (response.isOk) {
      final List<GenreModel> genreList = GenreModel.genreList(response.body['genres']);
      change(genreList, status: RxStatus.success());
    } else {
      change([], status: RxStatus.error(response.body['status_message']));
    }
  }
}
