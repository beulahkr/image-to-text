import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

String textOutput = "";

class _MyAppState extends State<MyApp> {
  final ImagePicker picker = ImagePicker();
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.medium);
    await _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Widget _buildCameraPreview() {
    if (!_cameraController.value.isInitialized) {
      return Container();
    }

    return AspectRatio(
      aspectRatio: _cameraController.value.aspectRatio,
      child: CameraPreview(_cameraController),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
              backgroundColor: const Color.fromARGB(251, 166, 183, 240),
              body: Column(
                children: [
                  Stack(
                    children: [
                      _buildCameraPreview(),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: GestureDetector(
                          onTap: () async {
                            final XFile? image =
                                await _cameraController.takePicture();
                            String a = await getImageTotext(image!.path);
                            setState(() {
                              textOutput = a;
                            });
                          },
                          child: const Icon(
                            Icons.add_a_photo_rounded,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 300,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            textOutput,
                            style: const TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      )),
                ],
              ))),
    );
  }
}

Future getImageTotext(final imagePath) async {
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  final RecognizedText recognizedText =
      await textRecognizer.processImage(InputImage.fromFilePath(imagePath));
  String text = recognizedText.text.toString();
  return text;
}
