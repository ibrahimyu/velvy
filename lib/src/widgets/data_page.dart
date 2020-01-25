import 'package:flutter/material.dart';
import 'package:velvy/src/widgets/paginator.dart';
import 'package:velvy/velvy.dart';

typedef QueryResultBuilder = Widget Function(
    BuildContext context, QueryResult result);

class DataPage extends StatefulWidget {
  final Service service;
  final String title;
  final QueryResultBuilder builder;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Widget floatingActionButton;
  final Widget drawer;

  const DataPage({
    Key key,
    this.title,
    this.service,
    this.builder,
    this.floatingActionButton,
    this.drawer,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.endDocked,
  }) : super(key: key);

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  bool _isSearching = false;
  TextEditingController _searchCtrl = TextEditingController(text: '');
  Widget content;

  Future<QueryResult> result;

  int currentPage = 1;

  @override
  void initState() {
    super.initState();

    reload();
  }

  void reload() {
    setState(() {
      result = widget.service.find(
          params: '?page=$currentPage' +
              (_searchCtrl.text.isNotEmpty ? '&q=${_searchCtrl.text}' : ''));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.drawer,
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                autofocus: true,
                controller: _searchCtrl,
                decoration: InputDecoration(
                  hintText: 'Search',
                ),
                style: TextStyle(color: Colors.white),
                onChanged: (val) {
                  setState(() {
                    reload();
                  });
                },
              )
            : Text(widget.title),
        actions: <Widget>[
          _isSearching
              ? IconButton(
                  icon: Icon(Icons.close),
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
      body: FutureBuilder<QueryResult>(
        future: result,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('Loading...'),
            );
          }

          return widget.builder(context, snapshot.data);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_left),
              onPressed: currentPage > 1
                  ? () {
                      if (currentPage > 1) {
                        setState(() {
                          currentPage--;
                          reload();
                        });
                      }
                    }
                  : null,
            ),
            Text("$currentPage"),
            IconButton(
              icon: Icon(Icons.arrow_right),
              onPressed: () {
                setState(() {
                  currentPage++;
                  reload();
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
    );
  }
}
