import 'package:MDb/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PosterAndRating extends StatelessWidget {
  final Detail detail;
  PosterAndRating(this.detail);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
      children: <Widget>[
        Container(
          width: mediaQuery.size.width,
          child: Text(
            detail.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 40,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 5,
                  color: Colors.black45,
                  offset: Offset(4, 4),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 60,
        ),
        Container(
          width: mediaQuery.size.width,
          child: Row(
            children: <Widget>[
              Container(
                height: 250,
                child: Card(
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      detail.poster,
                    ),
                  ),
                ),
              ),
              Container(
                width: 200,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/139px-Rotten_Tomatoes.png',
                          height: 30,
                        ),
                        Text('80%')
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.imdb,
                          size: 40,
                        ),
                        Text('${detail.imdb}/10')
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/meta.png',
                          height: 30,
                        ),
                        Text(detail.mS == 'N/A'
                            ? '${detail.mS}'
                            : '${detail.mS}/100')
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
