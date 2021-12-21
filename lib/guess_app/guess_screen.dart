
import 'dart:math';

import 'package:flutter/material.dart';

class GuessScreen extends StatefulWidget {
  const GuessScreen({Key? key}) : super(key: key);

  @override
  _GuessScreenState createState() => _GuessScreenState();
}

class _GuessScreenState extends State<GuessScreen> {

  var _tfController = TextEditingController();
  var _message = "Guess a num. btw 0-100";
  var _textColor = Colors.red;
  var _imagePath = "images/think.png";
  var _randGen = Random();
  var _number;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _number = _randGen.nextInt(101);
  }

  void _checkAnswer([String text = ""]) {
    var guess = int.parse(_tfController.text);
    if (guess > _number) {
      _message = "Guess a smaller number";
    }
    else if (guess < _number) {
      _message = "Guess a greater number";
    }
    else {
      _message = "You guessed Right!!";
      _imagePath = "images/happy.png";
      _textColor = Colors.green;
    }
    setState(() {

    });
  }

  void _playAgain() {
    _message = "Guess a num. btw 0-100";
    _textColor = Colors.red;
    _imagePath = "images/think.png";
    _tfController.text = "";
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Guess Game"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _playAgain,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(_imagePath,),
            Text(
                _message,
              style: TextStyle(
                fontSize: 24,
                color: _textColor
              ),
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: _tfController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter your name"
              ),
              onSubmitted: _checkAnswer,
            ),
            ElevatedButton(
              child: Text("Click Me"),
              onPressed: _checkAnswer,
            )
          ],
        ),
      ),
    );
  }
}
