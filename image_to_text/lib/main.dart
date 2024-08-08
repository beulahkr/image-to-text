import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_to_text/autofill_form.dart';
import 'package:image_to_text/camera_view.dart'; // Import your CameraView widget

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  MyApp({required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add New Equipment Item',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(camera: camera),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final CameraDescription camera;

  const MyHomePage({super.key, required this.camera});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CameraController _controller;
  String _recognizedText = '';
  bool _showForm = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Equipment'),
      ),
      body: _showForm
          ? AutofillForm(suggestions: _recognizedText.split(RegExp(r'\s|\n')))
          : Column(
              children: <Widget>[
                Expanded(
                  child: CameraView(
                    cameraController: _controller,
                    onPictureTaken: (text) {
                      setState(() {
                        _recognizedText = text;
                        _showForm = true;
                      });
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
