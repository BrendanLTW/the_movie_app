import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_movie_app/app/config/constants.dart';
import 'package:the_movie_app/app/controllers/movie_controller.dart';
import 'package:the_movie_app/app/data/models/movie_model.dart';

import 'widgets/filter.dart';

class MovieDetailPage extends GetView<MovieDetailController> {
  const MovieDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: controller.obx((state) {
        MovieDetailModel movieDetail = state!;
        List<FilterWidget> filters = [];
        for (var v in movieDetail.genres) {
          filters.add(FilterWidget(name: v.name));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 10,
              child: CachedNetworkImage(
                imageUrl: Constant.imageURL + movieDetail.backdropPath,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieDetail.title,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(movieDetail.releaseDate),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(movieDetail.voteAverage.toStringAsFixed(2)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: filters,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(movieDetail.overview)
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
