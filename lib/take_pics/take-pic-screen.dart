
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
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return CameraPreview(camController);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
