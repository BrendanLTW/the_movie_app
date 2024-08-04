
import 'package:get/get.dart';
import 'package:the_movie_app/app/controllers/movie_controller.dart';


class MovieBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MovieController());
  }
}

class MovieDetailBinding implements Bindings {
  MovieDetailBinding({required this.movieID});
  final int movieID;
  @override
  void dependencies() {
    Get.put( MovieDetailController(movieID: movieID));
  }
}