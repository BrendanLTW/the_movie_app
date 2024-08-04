import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:the_movie_app/app/controllers/genre_controller.dart';
import 'package:the_movie_app/app/controllers/movie_controller.dart';
import 'package:the_movie_app/app/data/models/movie_model.dart';

class FilterWidget extends GetView<GenreController> {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.bottomSheet(BottomSheet(
            backgroundColor: const Color(0xFF17191D),
            onClosing: () {},
            builder: (context) {
              return controller.obx(
                (state) {
                  List<GenreModel> genreList = state!;
                  List<FilterButton> filterList = [];
                  for (var v in genreList) {
                    filterList.add(FilterButton(genre: v));
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Genre',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: filterList,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(onPressed: () {
                                Get.find<MovieController>().clearFilter();
                              }, 
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                                side: const BorderSide(color: Colors.red)
                              ),
                              child: const Text('Clear')),
                            ),
                            const SizedBox(width: 20,),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Get.find<MovieController>().applyFilter();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white
                                  ),
                                  child: const Text('Apply')),
                            ),
                          ],
                        ),
                        const SafeArea(child: SizedBox())
                      ],
                    ),
                  );
                },
              );
            },
          ));
        },
        icon: const Icon(Icons.filter_alt));
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({required this.genre, Key? key}) : super(key: key);

  final GenreModel genre;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieController>(builder: (movieCtrl) {
      return GestureDetector(
        onTap: () {
          movieCtrl.selectGenre(genre.id);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
              border: Border.all(
                  color: movieCtrl.genreFilter.contains(genre.id)
                      ? Colors.red
                      : Colors.grey),
              borderRadius: BorderRadius.circular(20),
              color: movieCtrl.genreFilter.contains(genre.id)
                  ? Colors.red
                  : Colors.transparent),
          child: Text(
            genre.name,
            style: TextStyle(
                color: movieCtrl.genreFilter.contains(genre.id)
                    ? Colors.white
                    : Colors.grey),
          ),
        ),
      );
    });
  }
}
