import 'package:MDb/screens/detail_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/search_provider.dart';

class SearchResult extends StatelessWidget {
  final ResultList result;
  SearchResult(this.result);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPageScreen(result.id),
          ),
        );
      },
      child: Card(
        child: Container(
          height: 200,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(
            children: <Widget>[
              Container(
                height: 200,
                width: 150,
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/placeholder.png'),
                  image: NetworkImage(result.poster),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        result.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(result.year),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
