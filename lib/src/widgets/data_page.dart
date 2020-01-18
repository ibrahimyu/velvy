import 'package:flutter/material.dart';
import 'package:velvy/src/widgets/paginator.dart';

class DataPage extends StatefulWidget {
  final String title;
  const DataPage({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  bool _isSearching;
  TextEditingController _searchCtrl;
  Widget content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchCtrl,
                decoration: InputDecoration(hintText: 'Search'),
              )
            : Text(widget.title),
        actions: <Widget>[
          _isSearching
              ? IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _isSearching = true;
                    });
                  },
                )
        ],
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: content,
        ),
        Paginator()
      ]),
    );
  }
}
