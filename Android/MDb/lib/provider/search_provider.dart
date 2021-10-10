import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Detail {
  final String title;
  final String year;
  final String poster;
  final String rated;
  final String release;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String rT;
  final String imdb;
  final String mS;
  final String totalSeason;
  final String awards;
  Detail({
    this.actors,
    this.awards,
    this.director,
    this.genre,
    this.imdb,
    this.mS,
    this.plot,
    this.poster,
    this.rT,
    this.rated,
    this.release,
    this.runtime,
    this.title,
    this.totalSeason,
    this.writer,
    this.year,
  });
}

class ResultList {
  final String title;
  final String year;
  final String poster;
  final String id;

  ResultList({
    @required this.title,
    @required this.year,
    @required this.poster,
    @required this.id,
  });
}

class SearchProvider extends ChangeNotifier {
  List<ResultList> _result = [];
  Detail _detail;

  List<ResultList> get result {
    return [..._result];
  }

  Detail get detail {
    return _detail;
  }

  Future<List<ResultList>> searchDb(String search, String type) async {
    final url = 'http://www.omdbapi.com/?apikey=21839538&s=';
    try {
      final response = await http.get('${url + search}&type=$type');
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (responseData['Error'] != null) {
        throw responseData['Error'];
      }
      final searchResult = responseData['Search'];
      final List<ResultList> loadedResult = [];
      searchResult.forEach(
        (search) {
          // print(search);
          loadedResult.add(
            ResultList(
              title: search['Title'],
              year: search['Year'],
              poster: search['Poster'],
              id: search['imdbID'],
            ),
          );
        },
      );
      _result = loadedResult;
      notifyListeners();
      return loadedResult;
    } catch (error) {
      throw error;
    }
  }

  Future<Detail> getDetail(String id) async {
    print(id);
    final url = 'http://www.omdbapi.com/?apikey=21839538&i=';
    try {
      final response = await http.get('${url + id}&plot=full');
      print(response.body);
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      // print(json.decode(responseData['Awards']));
      Detail detail = Detail(
        title: responseData['Title'],
        year: responseData['Year'],
        rated: responseData['Released'],
        poster: responseData['Poster'],
        release: responseData['Released'],
        runtime: responseData['Runtime'],
        genre: responseData['Genre'],
        director: responseData['Director'],
        plot: responseData['Plot'],
        writer: responseData['Writer'],
        actors: responseData['Actors'],
        imdb: responseData['imdbRating'],
        awards: responseData['Awards'],
        mS: responseData['Metascore'],
      );
      return detail;
    } catch (err) {
      print(err);
      throw err;
    }
  }
}
