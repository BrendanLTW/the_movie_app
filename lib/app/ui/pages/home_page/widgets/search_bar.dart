import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:the_movie_app/app/controllers/movie_controller.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(() => Get.find<MovieController>().openSearch.value
            ? GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  Get.find<MovieController>().openSearch.value = false;
                  Get.find<MovieController>().searchCtrl.clear();
                },
                child: const Icon(Icons.arrow_back_ios))
            : const Icon(Icons.search)),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 10),
            decoration: BoxDecoration(
                color: Color(0xFF1C1E25),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: Colors.red,
                    controller: Get.find<MovieController>().searchCtrl,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: 'Search'),
                    onTap: () {
                      Get.find<MovieController>().openSearch.value = true;
                      Get.find<MovieController>().loadHistory();
                    },
                    onSubmitted: (value) {
                      if (value.isEmpty) {
                        Get.find<MovieController>().loadNowPlayingMovie();
                      } else {
                        Get.find<MovieController>().searchMovie();
                      }
                      Get.find<MovieController>().openSearch.value = false;
                    },
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Get.find<MovieController>().searchCtrl.clear();
                      Get.find<MovieController>().applyFilter();
                    },
                    icon: const Icon(Icons.cancel,))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
