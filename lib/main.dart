import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

final _width = 300.0;
final _height = 300.0;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Widget _createGlitterPiece(){
    final random = math.Random();
    final pieceSize = 10.0;
    final piece = Container(width: pieceSize, height: pieceSize, color: Colors.blue,);
    final topOffSet = random.nextDouble() * (_width - pieceSize);
    final leftOffSet = random.nextDouble() * (_height - pieceSize);
    return Positioned(
      top: topOffSet,
      left: leftOffSet,
      child: piece,
    );
  }

  List<Widget> _createGlitterPieces(int numPieces){
    final pieces = <Widget>[];
    for(var i = 0; i < numPieces; i++){
      pieces.add(_createGlitterPiece());
    }
    return pieces;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          height: _height,
          width: _width,
          color: Colors.pink[100],
          child: Stack(
            children: _createGlitterPieces(10),
          ),
        ),
      )
    );
  }
}
