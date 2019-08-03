import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

const _width = 300.0;
const _height = 300.0;
const _duration = Duration(milliseconds: 500);
final _colorTween = ColorTween(begin: Colors.green, end: Colors.transparent);

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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    );
    _animation= _colorTween.animate(_controller);
    _controller.addStatusListener((AnimationStatus status){
      if(status == AnimationStatus.completed){
        _controller.reverse();
      }else if(status == AnimationStatus.dismissed){
        _controller.forward();
      }
    });
    _controller.forward();
  }


//  @override
//  void didUpdateWidget(MyHomePage oldWidget) {
//    super.didUpdateWidget(oldWidget);
//    _controller.duration = _duration;
//  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _createAnimatedGlitterPiece(){
    final random = math.Random();
    final pieceSize = 10.0;
    final piece = AnimatedBuilder(animation: _animation, builder: (BuildContext context, Widget widget){
      return Container(width: pieceSize, height: pieceSize, color: _animation.value,);
    });
    final topOffSet = random.nextDouble() * (_width - pieceSize);
    final leftOffSet = random.nextDouble() * (_height - pieceSize);
    return Positioned(
      top: topOffSet,
      left: leftOffSet,
      child: piece,
    );
  }

  Widget _createStaticGlitterPiece(){
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
      pieces.add(_createStaticGlitterPiece());
    }
    for(var i = 0; i < numPieces; i++){
      pieces.add(_createAnimatedGlitterPiece());
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
