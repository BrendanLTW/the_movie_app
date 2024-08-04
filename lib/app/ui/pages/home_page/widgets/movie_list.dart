import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:the_movie_app/app/bindings/movie_binding.dart';

import '../../../../config/constants.dart';
import '../../../../controllers/movie_controller.dart';
import '../../../../data/models/movie_model.dart';
import '../../movie_page/movie_detail_page.dart';

class MovieList extends StatelessWidget {
  const MovieList({required this.movieList, Key? key}) : super(key: key);

  final List<MovieModel> movieList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemCount: movieList.length,
      itemBuilder: (context, index) {
        MovieModel movie = movieList[index];
        return GestureDetector(
          onTap: () {
            Get.to(() => MovieDetailPage(), binding: MovieDetailBinding(movieID: movie.id));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: Constant.imageURL + movie.posterPath,
              errorWidget: (context, url, error) {
                return Placeholder();
              },
            ),
          ),
        );
      },
    );
  }
}

class NowPlayingMovieList extends GetView<MovieController> {
  const NowPlayingMovieList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      List<MovieModel> movieList = state ?? [];
      return MovieList(movieList: movieList);
    });
  }
}
