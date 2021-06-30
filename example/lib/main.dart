import 'dart:async';

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
  final normalImage = "https://firebasestorage.googleapis.com/v0/b/constructin-15d0f.appspot.com/o/projects%2Fcaptures%2F2fb50a47-3ca4-4b1a-90c9-6790fc412db0.png?alt=media&token=957a5033-bd9c-45c0-b42f-8a9ee31faf94";

  StreamController<PanoramaCoordinates>? upController;
  StreamController<PanoramaCoordinates>? downController;

  PanoramaSync? upToDownSync;
  PanoramaSync? downToUpSync;

  @override
  void initState() {
    super.initState();

    _startSync();
  }

  _closeSync() {
    downController?.close();
    upController?.close();

    setState(() {
      upToDownSync = null;
      downToUpSync = null;
    });
  }

  _startSync() {
    downController = StreamController<PanoramaCoordinates>();
    upController = StreamController<PanoramaCoordinates>();

    setState(() {
      upToDownSync = PanoramaSync(
          from: upController,
          to: downController
      );

      downToUpSync = PanoramaSync(
          from: downController,
          to: upController
      );
    });
  }

  @override
  void dispose() {
    super.dispose();

    _closeSync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 300,
                child: Panorama(
                  key: Key("1"),
                  sync: upToDownSync,
                  loader: Center(child: Text("Loading...")),
                  child: Image.network(
                      normalImage
                  ),
                ),
              ),

              Container(
                height: 300,
                child: Panorama(
                  key: Key("2"),
                  sync: downToUpSync,
                  loader: Center(child: Text("Loading 2...")),
                  child: Image.network(
                      rotatedImage
                  ),
                ),
              )
            ],
          ),

          Row(
            children: [
              ElevatedButton(
                onPressed: _closeSync,
                child: Text("Stop")
              ),

              ElevatedButton(
                  onPressed: _startSync,
                  child: Text("Start")
              ),
            ],
          )
        ],
      )
    );
  }
}
