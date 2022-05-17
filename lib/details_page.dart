import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
class RecognizedText extends StatefulWidget {
  File filePath;
  RecognizedText(this.filePath);

  @override
  _RecognizedTextState createState() => _RecognizedTextState();
}

class _RecognizedTextState extends State<RecognizedText> {
  TextRecognizer _textRecognizer = TextRecognizer();
  String? recognizedTextT = '';
  // InputImage? inputImage = ;
  @override
  void initState(){
    processImage(widget.filePath);
    super.initState();
  }

  Future processImage(File imgFile)async{
    final recognizedImage = await _textRecognizer.processImage(InputImage.fromFile(imgFile));
    setState(() {
      recognizedTextT = recognizedImage.text;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4f000b),
        title: Text("Recognized Text"),
      ),
      body:  ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              margin: EdgeInsets.all(20),
                child: Text("${recognizedTextT.toString()}" , style: TextStyle(fontSize: 18),)),
          ],
        ), //


    );
  }
}
