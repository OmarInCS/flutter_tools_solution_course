
import 'package:flutter/material.dart';

class HelloScreen extends StatefulWidget {
  const HelloScreen({Key? key}) : super(key: key);

  @override
  _HelloScreenState createState() => _HelloScreenState();
}

class _HelloScreenState extends State<HelloScreen> {

  var tfController = TextEditingController();
  var message = "Hello, Guest";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                message,
              style: TextStyle(
                fontSize: 24,
                color: Colors.red
              ),
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: tfController,
              decoration: InputDecoration(
                hintText: "Enter your name"
              ),
            ),
            ElevatedButton(
              child: Text("Click Me"),
              onPressed: () {
                setState(() {
                  message = "Hello, ${tfController.text}";
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
