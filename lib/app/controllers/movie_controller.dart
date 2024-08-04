import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../data/models/movie_model.dart';
import '../data/provider/api/api.dart';

class MovieController extends GetxController with StateMixin<List<MovieModel>> {
  final TextEditingController searchCtrl = TextEditingController();
  final List<int> genreFilter = [];
  final List<int> appliedFilter = [];
  List<MovieModel> movieList = [];
  List<String> historyList = [];

  RxBool openSearch = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNowPlayingMovie();
    loadHistory();
  }

  loadNowPlayingMovie() async {
    change([], status: RxStatus.loading());
    final Response response =
        await API(path: 'movie/now_playing').httpRequest();
    if (response.isOk) {
      movieList = MovieModel.movieList(response.body['results']);
      change(movieList, status: RxStatus.success());
    } else {
      change([], status: RxStatus.error(response.body['status_message']));
    }
  }

  loadHistory() async {
     final SharedPreferences sp = await SharedPreferences.getInstance();
     List<String> historyList = await sp.getStringList('history') ?? [];
     this.historyList = [];
     this.historyList.addAll(historyList.reversed.toList());
     print(this.historyList);
     update();
  }

  searchMovie() async {
    change([], status: RxStatus.loading());
   final SharedPreferences sp = await SharedPreferences.getInstance();
     List<String> historyList = await sp.getStringList('history') ?? [];
    if (historyList.length >= 10) {
      historyList.remove(historyList.first);
    }
    if (!historyList.contains(searchCtrl.text)) {
      historyList.add(searchCtrl.text);
    }
    sp.setStringList('history', historyList);
    final Response response =
        await API(path: 'search/movie', queryParam: {"query": searchCtrl.text})
            .httpRequest();
    if (response.isOk) {
      movieList = MovieModel.movieList(response.body['results']);
      change(movieList, status: RxStatus.success());
    } else {
      change([], status: RxStatus.error(response.body['status_message']));
    }
  }

  filterMovie() async {
    change([], status: RxStatus.loading());
    List<MovieModel> currentMovie = movieList;
    List<MovieModel> filteredMovie = [];

    if (genreFilter.isNotEmpty) {
      for (var i in currentMovie) {
        for (var j in genreFilter) {
          if (i.genreIds.contains(j)) {
            filteredMovie.add(i);
            break;
          }
        }
      }
      change(filteredMovie, status: RxStatus.success());
    } else {
      if (searchCtrl.text.isNotEmpty) {
        searchMovie();
      } else {
        loadNowPlayingMovie();
      }
    }
  }

  void selectGenre(int id) {
    if (genreFilter.contains(id)) {
      genreFilter.remove(id);
    } else {
      genreFilter.add(id);
    }
    update();
  }

  void clearFilter() {
    appliedFilter.clear();
    genreFilter.clear();
    filterMovie();
    Get.back();
    update();
  }

  void applyFilter() {
    appliedFilter.clear();
    appliedFilter.addAll(genreFilter);
    filterMovie();
    Get.back();
    update();
  }

  void initGenre() {
    genreFilter.clear();
    genreFilter.addAll(appliedFilter);
    update();
  }
}

class MovieDetailController extends GetxController with StateMixin<MovieDetailModel> {
  MovieDetailController({required this.movieID});
  final int movieID;

  @override
  void onInit() {
    super.onInit();
        loadDetail();
  }

  void loadDetail() async{
     change(MovieDetailModel(), status: RxStatus.loading());
    final Response response =
        await API(path: 'movie/${movieID}',).httpRequest();
    if (response.isOk) {
      MovieDetailModel movieDetail = MovieDetailModel.fromJson(response.body);
      change(movieDetail, status: RxStatus.success());
    } else {
      change(MovieDetailModel(), status: RxStatus.error(response.body['status_message']));
    }
  }
}