import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BackGround extends StatefulWidget {
  @override
  _BackGroundState createState() => _BackGroundState();
}

class _BackGroundState extends State<BackGround> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BackgroundClipper(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColorDark,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var height = size.height * 0.3;
    var width = size.width;
    path.lineTo(0, height - 30);
    path.quadraticBezierTo(
      width / 8,
      height,
      width / 4,
      height,
    );
    path.quadraticBezierTo(
      (width / 8) * 3,
      height,
      width / 2,
      height - 30,
    );
    path.quadraticBezierTo(
      (width / 8) * 5,
      height - 60,
      (width / 4) * 3,
      height - 60,
    );
    path.quadraticBezierTo(
      (width / 8) * 7,
      height - 60,
      width,
      height - 30,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
