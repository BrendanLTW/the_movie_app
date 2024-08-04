
import 'package:get/get.dart';
import '../controllers/genre_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/movie_controller.dart';


class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut(() => MovieController());
    Get.put(GenreController());
  }
}