import 'package:flutter/material.dart';
import 'package:velvy/src/core/model.dart';

typedef ItemBuilder<T> = Widget Function(BuildContext context, T item);

class DataList<T extends Model> extends StatelessWidget {
  final Widget loading;
  final Widget empty;
  final Future<List<T>> future;
  final bool shrinkWrap;
  final ScrollPhysics physics;
  final ItemBuilder<T> builder;

  const DataList({
    Key key,
    this.loading,
    this.empty,
    this.future,
    this.shrinkWrap,
    this.physics,
    this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return loading ?? Container();
        }

        if (!snapshot.hasData || snapshot.data.length == 0) {
          return empty ?? Container();
        }

        return ListView.builder(
          shrinkWrap: shrinkWrap,
          physics: physics,
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) =>
              builder(context, snapshot.data[index]),
        );
      },
    );
  }
}
