import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final String level;
  const QuizScreen({Key? key, this.level = "Easy"}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late int _x;
  late int _y;
  final randGen = new Random();
  var _choices = [];
  var _colors = [Colors.green, Colors.red, Colors.blue, Colors.orangeAccent];

  var _numberOfQuestions = 5;
  var _wrong = 0;

  Timer? timer;
  int seconds = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateQuestion();
    initTimer();
  }

  void generateQuestion() {
    _x = randGen.nextInt(11);
    _y = randGen.nextInt(11);
    _choices = [];

    _choices.add(_x * _y);
    for (int i = 0; i < 3; i++) {
      var x = randGen.nextInt(11);
      var y = randGen.nextInt(11);
      _choices.add(x * y);
    }
    _choices.shuffle();
  }

  void checkChoice(int i) {
    initTimer();
    var answer = _choices[i];
    String message;
    if (answer == _x * _y) {
      message = "Correct Answer";
    } else {
      message = "Wrong Answer";
      _wrong++;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    ));

    checkEndOfQuestions();
  }

  void checkEndOfQuestions() {
    _numberOfQuestions--;

    if (_numberOfQuestions != 0) {
      setState(() {
        generateQuestion();
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Your score"),
          content: Text("Score: ${5 - _wrong} out of 5"),
          actions: [
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName("/"));
              },
            )
          ],
        ),
      );
    }
  }

  void initTimer() {
    timer?.cancel();
    if (widget.level == "Easy") {
      seconds = 30;
    }
    else if (widget.level == "Normal") {
      seconds = 15;
    }
    else {
      seconds = 5;
    }

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        _wrong++;
        checkEndOfQuestions();
        initTimer();
      }
      setState(() {
        seconds--;
      });

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.level} Quiz"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "$seconds",
              style: TextStyle(
                fontSize: 20
              ),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                "What's ${_x} * ${_y} ?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36),
              ),
            ),
          ),
          GridView.builder(
            itemCount: _choices.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            shrinkWrap: true,
            itemBuilder: (context, i) => ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: _colors[i],
                textStyle: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text("${_choices[i]}"),
              onPressed: () => checkChoice(i),
            ),
          )
        ],
      ),
    );
  }
}
