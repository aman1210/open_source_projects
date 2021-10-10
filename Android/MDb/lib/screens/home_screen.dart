import 'package:MDb/screens/change_theme.dart';
import 'package:MDb/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget item(String name, IconData icon, Color color) {
    return Container(
      child: Card(
        elevation: 14,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        name,
                        style: TextStyle(
                          color: color,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Material(
                      color: color,
                      borderRadius: BorderRadius.circular(24),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: FaIcon(
                          icon,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Database'),
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        padding: EdgeInsets.all(12),
        children: <Widget>[
          GestureDetector(
              onTap: () => Navigator.of(context)
                  .pushNamed(SearchScreen.routeName, arguments: 'series'),
              child: item('Series', Icons.tv, Colors.green)),
          GestureDetector(
              onTap: () => Navigator.of(context)
                  .pushNamed(SearchScreen.routeName, arguments: 'episode'),
              child: item('Episode', Icons.videocam, Colors.deepPurple)),
          GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamed(SearchScreen.routeName, arguments: 'movie'),
            child: item(
              'Movie',
              FontAwesomeIcons.film,
              Colors.amber,
            ),
          ),
          GestureDetector(
            onTap: () =>
                Navigator.of(context).pushNamed(ChangeTheme.routerName),
            child: item('Change Theme', Icons.settings, Colors.grey),
          ),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 250),
          StaggeredTile.extent(2, 250),
          StaggeredTile.extent(4, 250),
          StaggeredTile.extent(4, 150),
        ],
      ),
    );
  }
}
