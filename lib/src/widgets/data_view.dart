import 'package:flutter/material.dart';
import 'package:velvy/velvy.dart';

class DataView<T> extends StatelessWidget {
  final Future<T> future;
  final ItemBuilder<T> builder;

  const DataView({
    Key key,
    this.future,
    this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        return builder(context, snapshot.data);
      },
    );
  }
}
