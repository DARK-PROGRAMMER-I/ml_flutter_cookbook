import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PictureScreen extends StatefulWidget {
  final XFile? picture;
  PictureScreen(this.picture);

  @override
  _PictureScreenState createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Picture'),
        ),
    );
  }
}
