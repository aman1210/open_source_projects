import 'package:MDb/widgets/search_result.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../provider/search_provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  List<ResultList> result = [];
  var loading = false;

  @override
  Widget build(BuildContext context) {
    final type = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Search $type'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search",
              ),
              onSubmitted: (value) async {
                result = [];
                if (value.length > 0) {
                  setState(() {
                    loading = true;
                  });
                  try {
                    result = await Provider.of<SearchProvider>(context,
                            listen: false)
                        .searchDb(value, type);
                    setState(() {
                      loading = false;
                    });
                  } catch (err) {
                    print(err);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text(err),
                        actions: <Widget>[
                          FlatButton.icon(
                              onPressed: () {
                                setState(() {
                                  loading = false;
                                });
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.check),
                              label: Text('Got it!'))
                        ],
                      ),
                    );
                  }
                }
              },
            ),
          ),
          if (loading)
            Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (result != null)
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: result.map((s) {
                      return SearchResult(s);
                    }).toList(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
