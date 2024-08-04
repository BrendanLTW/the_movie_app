import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_movie_app/app/controllers/movie_controller.dart';
import 'package:the_movie_app/app/ui/pages/home_page/widgets/history_list.dart';
import 'package:the_movie_app/app/ui/pages/home_page/widgets/movie_list.dart';
import 'package:the_movie_app/app/ui/pages/home_page/widgets/search_bar.dart';

import '../../../controllers/home_controller.dart';
import 'widgets/filter.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height:70,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: SearchBarWidget(),
                ),
                FilterWidget()
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
              child: Obx(() => Get.find<MovieController>().openSearch.value
                  ? const HistoryList()
                  : const NowPlayingMovieList()))
        ],
      ),
    );
  }
}
