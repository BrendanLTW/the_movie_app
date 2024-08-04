import 'package:flutter/material.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({required this.name, Key? key}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        name,
        style: const TextStyle(
            color:Colors.red),
      ),
    );
  }
}
