import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';
import 'package:vector_math/vector_math_64.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Panorama',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Flutter Panorama'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final rotatedImage = "https://firebasestorage.googleapis.com/v0/b/constructin-15d0f.appspot.com/o/projects%2Fcaptures%2Fd7f2a7f4-a5b3-48f9-bfeb-69747f874d23.jpeg?alt=media&token=5fddf914-8a06-49a1-be67-350bb4ec98c5";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Stack(
        children: [
          Panorama(
            loader: Center(child: Text("Loading...")),
            child: Image.network(
                rotatedImage
            )
          ),
        ],
      )
    );
  }
}
