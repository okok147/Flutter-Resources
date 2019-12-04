import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lets_meet_flutter/main.dart';
import 'package:lets_meet_flutter/util/Global.dart';
import 'package:lets_meet_flutter/widget.dart';

class SearchDemo extends StatefulWidget {
  static const String routeName = '/material/search';

  @override
  _SearchDemoState createState() => new _SearchDemoState();
}

class _SearchDemoState extends State<SearchDemo> {
  final SearchDemoSearchDelegate _delegate = new SearchDemoSearchDelegate();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _lastIntegerSelected;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        leading: new IconButton(
          tooltip: 'Navigation menu',
          icon: new AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            color: Colors.white,
            progress: _delegate.transitionAnimation,
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        title: const Text('Numbers'),
        actions: <Widget>[
          new IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () async {
              final int selected = await showSearch<int>(
                context: context,
                delegate: _delegate,
              );
              if (selected != null && selected != _lastIntegerSelected) {
                if (this.mounted) {
                  setState(() {
                    _lastIntegerSelected = selected;
                  });
                }
              }
            },
          ),
          new IconButton(
            tooltip: 'More (not implemented)',
            icon: new Icon(
              Theme.of(context).platform == TargetPlatform.iOS
                  ? Icons.more_horiz
                  : Icons.more_vert,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new MergeSemantics(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text('Press the '),
                      Tooltip(
                        message: 'search',
                        child: Icon(
                          Icons.search,
                          size: 18.0,
                        ),
                      ),
                      Text(' icon in the AppBar'),
                    ],
                  ),
                  const Text(
                      'and search for an integer between 0 and 100,000.'),
                ],
              ),
            ),
            const SizedBox(height: 64.0),
            new Text(
                'Last selected integer: ${_lastIntegerSelected ?? 'NONE'}.')
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton.extended(
        tooltip: 'Back', // Tests depend on this label to exit the demo.
        onPressed: () {
          Navigator.of(context).pop();
        },
        label: const Text('Close demo'),
        icon: const Icon(Icons.close),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('Peter Widget'),
              accountEmail: Text('peter.widget@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                  'people/square/peter.png',
                  package: 'flutter_gallery_assets',
                ),
              ),
              margin: EdgeInsets.zero,
            ),
            new MediaQuery.removePadding(
              context: context,
              // DrawerHeader consumes top MediaQuery padding.
              removeTop: true,
              child: const ListTile(
                leading: Icon(Icons.payment),
                title: Text('Placeholder'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MeetusSearch extends SearchDelegate<String> {
  List<dynamic> data = [];

  Future getSearch() async {
    Response response = await Request.getDio()
        .get("meetup/search", data: {'Search': query.toString()});
    if (response.data["Code"] == 200) {
      data = response.data["Data"];
      // for (int i = 0; i < response.data["Data"].length; i++) {
      //   data.add(Container(
      //     child: Text(response.data["Data"][i].toString()),
      //   ));
      // }
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    print("action");
    // TODO: implement buildActions
    return [Container()];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // print("leading");
    // return Container();
    return new IconButton(
      tooltip: 'Back',
      icon: new AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
    // TODO: implement buildLeading
  }

  @override
  Widget buildResults(BuildContext context) {
    print("result");
    return Container(
        child: FutureBuilder(
      future: getSearch(),
      builder: (context, _) {
        return data.length == 0
            ? Container()
            : SearchSlider(
                data: data,
              );
      },
    ));
    // TODO: implement buildResults
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print("suggestion");
    return FutureBuilder(
      future: getSearch(),
      builder: (context, _) {
        return data.length == 0
            ? Container()
            : SearchSlider(
                data: data,
              );
      },
    );
    //getSearch();

    // TODO: implement buildSuggestions
  }
}

class SearchSlider extends StatefulWidget {
  final List data;
  const SearchSlider({Key key, this.data}) : super(key: key);
  @override
  _SearchSliderState createState() => _SearchSliderState();
}

class _SearchSliderState extends State<SearchSlider> {
  List<Widget> getMeetList() {
    List<Widget> a = new List();

    a = widget.data
        .where((f) => f["ID"] != null)
        .map((f) => MeetCard(f))
        .toList();

    //print("a is $a");
    return a;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Text("Search", style: Global.stlye_sliderTitle),
          ),
          Container(
            height: 127.0,
            child: new ListView(
              scrollDirection: Axis.horizontal,
              children: getMeetList(),
            ),
          )
        ],
      ),
    );
  }
}

class SearchDemoSearchDelegate extends SearchDelegate<int> {
  final List<int> _data =
      new List<int>.generate(100001, (int i) => i).reversed.toList();
  final List<int> _history = <int>[];

  @override
  Widget buildLeading(BuildContext context) {
    return new IconButton(
      tooltip: 'Back',
      icon: new AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<int> suggestions = query.isEmpty
        ? _history
        : _data.where((int i) => '$i'.startsWith(query));

    return new _SuggestionList(
      query: query,
      suggestions: suggestions.map((int i) => '$i').toList(),
      onSelected: (String suggestion) {
        query = suggestion;
        showResults(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final int searched = int.tryParse(query);
    if (searched == null || !_data.contains(searched)) {
      return new Center(
        child: new Text(
          '"$query"\n is not a valid integer between 0 and 100,000.\nTry again.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return new ListView(
      children: <Widget>[
        new _ResultCard(
          title: 'This integer',
          integer: searched,
          searchDelegate: this,
        ),
        new _ResultCard(
          title: 'Next integer',
          integer: searched + 1,
          searchDelegate: this,
        ),
        new _ResultCard(
          title: 'Previous integer',
          integer: searched - 1,
          searchDelegate: this,
        ),
      ],
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? new IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic),
              onPressed: () {
                query = 'TODO: implement voice input';
              },
            )
          : new IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
    ];
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({this.integer, this.title, this.searchDelegate});

  final int integer;
  final String title;
  final SearchDelegate<int> searchDelegate;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new GestureDetector(
      onTap: () {
        searchDelegate.close(context, integer);
      },
      child: new Card(
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            children: <Widget>[
              new Text(title),
              new Text(
                '$integer',
                style: theme.textTheme.headline.copyWith(fontSize: 72.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return new ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: new RichText(
            text: new TextSpan(
              text: suggestion.substring(0, query.length),
              style:
                  theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                new TextSpan(
                  text: suggestion.substring(query.length),
                  style: theme.textTheme.subhead,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}
