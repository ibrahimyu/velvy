import 'package:flutter/material.dart';

typedef ItemBuilder<T> = Widget Function(BuildContext context, T item);

class DataList<T> extends StatelessWidget {
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
    this.shrinkWrap = false,
    this.physics,
    this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return loading ?? Center(child: Text('Loading...'));
        }

        if (!snapshot.hasData || snapshot.data.length == 0) {
          return empty ?? Center(child: Text('No data.'));
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
