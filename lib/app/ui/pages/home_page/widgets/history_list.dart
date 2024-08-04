import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/movie_controller.dart';


class HistoryList extends StatelessWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieController>(
      builder: (movieCtrl) {
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          itemCount: movieCtrl.historyList.length,
          itemBuilder: (context, index) {
            String history = movieCtrl.historyList[index];
            return GestureDetector(
              onTap: () {
                movieCtrl.searchCtrl.text = history;
                movieCtrl.openSearch.value = false;
                FocusScope.of(context).unfocus();
                movieCtrl.applyFilter();
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 15),
                color: Colors.transparent,
                child: Row(
                  children: [
                    const Icon(Icons.history),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(history),
                    const Spacer(),
                    const Icon(Icons.close, size: 18,)
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }
}
