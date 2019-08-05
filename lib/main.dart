import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

const _width = 300.0;
const _height = 500.0;
const _duration = Duration(milliseconds: 300);
final _random = math.Random();

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
//  Animation _animation;
  
  Color _getRandomColor(){
    return Color.fromARGB(255, _random.nextInt(255), _random.nextInt(255), _random.nextInt(255));
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    );
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
    final colorTween = ColorTween(begin: _getRandomColor(), end: Colors.transparent);
    final animation = colorTween.animate(_controller);
    final pieceSize = 4.0;
    final piece = AnimatedBuilder(animation: animation, builder: (BuildContext context, Widget widget){
      return Container(width: pieceSize, height: pieceSize, color: animation.value,);
    });
    final topOffSet = _random.nextDouble() * (_height - pieceSize);
    final leftOffSet = _random.nextDouble() * (_width - pieceSize);
    return Positioned(
      top: topOffSet,
      left: leftOffSet,
      child: piece,
    );
  }

  Widget _createReverseAnimatedGlitterPiece(){
    final colorTween = ColorTween(begin: Colors.transparent, end:_getRandomColor());
    final animation = colorTween.animate(_controller);
    final pieceSize = 7.0;
    final piece = AnimatedBuilder(animation: animation, builder: (BuildContext context, Widget widget){
      return Container(width: pieceSize, height: pieceSize, color: animation.value,);
    });
    final topOffSet = _random.nextDouble() * (_height - pieceSize);
    final leftOffSet = _random.nextDouble() * (_width - pieceSize);
    return Positioned(
      top: topOffSet,
      left: leftOffSet,
      child: piece,
    );
  }

  Widget _createStaticGlitterPiece(){
    final pieceSize = 10.0;
    final piece = Container(width: pieceSize, height: pieceSize, color: _getRandomColor(),);
    final topOffSet = _random.nextDouble() * (_height - pieceSize);
    final leftOffSet = _random.nextDouble() * (_width - pieceSize);
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
    for(var i = 0; i < numPieces; i++){
      pieces.add(_createReverseAnimatedGlitterPiece());
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
            children: _createGlitterPieces(1000),
          ),
        ),
      )
    );
  }
}
