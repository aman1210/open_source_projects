import 'package:MDb/provider/search_provider.dart';
import 'package:flutter/material.dart';

class ShowDetails extends StatelessWidget {
  final Detail detail;
  ShowDetails(this.detail);

  Widget printTitle(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            decoration: TextDecoration.underline,
            shadows: [
              Shadow(
                blurRadius: 1,
                color: Colors.white12,
                offset: Offset(2, 2),
              ),
            ]),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget printDetail(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: Column(
        children: <Widget>[
          printTitle('Plot'),
          printDetail(detail.plot),
          printTitle('Director'),
          printDetail(detail.director),
          printTitle('Writer'),
          printDetail(detail.writer),
          printTitle('Actors'),
          printDetail(detail.actors),
          printTitle('Awards'),
          printDetail(detail.awards),
        ],
      ),
    );
  }
}
