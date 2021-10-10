import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/search_provider.dart';
import '../widgets/details.dart';
import '../widgets/background_clip.dart';
import '../widgets/poster_and_rating.dart';

class DetailPageScreen extends StatefulWidget {
  static const routeName = '/detail-page';
  final String id;
  DetailPageScreen(this.id);
  @override
  _DetailPageScreenState createState() => _DetailPageScreenState();
}

class _DetailPageScreenState extends State<DetailPageScreen> {
  Detail detail;
  var isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() async {
    setState(() {
      isLoading = true;
    });
    detail = await Provider.of<SearchProvider>(context, listen: false)
        .getDetail(widget.id);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: <Widget>[
                BackGround(),
                Positioned(
                  top: (mediaQuery.size.height * 0.3) / 6,
                  child: Container(
                    height: mediaQuery.size.height,
                    width: mediaQuery.size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          PosterAndRating(detail != null ? detail : null),
                          ShowDetails(detail != null ? detail : null),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
