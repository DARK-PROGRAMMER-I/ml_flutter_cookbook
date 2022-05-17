import 'package:flutter/material.dart';
import 'package:ml_flutter_cookbook/camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primaryColor: Color(0xff4f000b)
      ),
      home: const MyHomePage(title: 'Text Recognition'  ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void takePicture() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen()));
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff4f000b),
          title: Text(widget.title ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/image.jpg')
            )
          )
        ),

        floatingActionButton: Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text('Take Picture', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),),
               SizedBox(width: 10,),
               FloatingActionButton(
                 backgroundColor: Color(0xff4f000b),
                onPressed: takePicture,
                tooltip: 'take picture',
                child: const Icon(Icons.camera, color: Colors.white,),
            ),
             ],),
        ),
      ),
    );
  }
}
