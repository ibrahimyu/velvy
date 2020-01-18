import 'package:flutter/material.dart';

class Paginator extends StatelessWidget {
  final int currentPage;
  final int totalPage;

  Paginator({
    this.currentPage,
    this.totalPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: () {},
        ),
        Expanded(
          child: Text('Page $currentPage of $totalPage'),
        ),
        IconButton(
          icon: Icon(Icons.arrow_right),
          onPressed: () {},
        ),
      ],
    );
  }
}
