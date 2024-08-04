
import 'package:get/get.dart';

import '../controllers/genre_controller.dart';


class GenreBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(GenreController());
  }
}