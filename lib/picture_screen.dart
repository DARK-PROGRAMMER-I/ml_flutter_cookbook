import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ml_flutter_cookbook/details_page.dart';

class PictureScreen extends StatefulWidget {
  final XFile picture;
  PictureScreen(this.picture);

  @override
  _PictureScreenState createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {

  @override
  Widget build(BuildContext context) {
    double deviceHight = MediaQuery.of(context).size.height;
    File? filePath = File(widget.picture.path);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff4f000b),
            title: Text('Picture'),
          ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Image Path : ${widget.picture.path}'),
            Container(
              height: deviceHight/1.5 ,
              child: Image.file(filePath),
            ),
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xff4f000b))
                      ),
                      onPressed: (){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RecognizedText(filePath) )
                        );
                      },
                      child: Text('Text Recognition', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
