
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePicScreen extends StatefulWidget {
  const TakePicScreen({Key? key}) : super(key: key);

  @override
  _TakePicScreenState createState() => _TakePicScreenState();
}

class _TakePicScreenState extends State<TakePicScreen> {

  late CameraController camController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Take Pic."),
      ),
      body: FutureBuilder(
        future: availableCameras().then((cameras) {
          camController = CameraController(
              cameras.first,
              ResolutionPreset.medium
          );

          return camController.initialize();
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }

          return CameraPreview(camController);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          await camController.initialize();

          var image = await camController.takePicture();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DisplayPicScreen(imgPath: image.path),));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class DisplayPicScreen extends StatelessWidget {
  const DisplayPicScreen({Key? key, required this.imgPath}) : super(key: key);
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Taken Pic"),
      ),
      body: Center(child: Image.file(File(imgPath))),
    );
  }
}

