import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class CameraView extends StatefulWidget {
  final CameraController cameraController;
  final Function(String) onPictureTaken;

  const CameraView(
      {super.key,
      required this.cameraController,
      required this.onPictureTaken});

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  Future getImageTotext(final imagePath) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(InputImage.fromFilePath(imagePath));
    String text = recognizedText.text.toString();
    print('Recognised Text: $text');
    return text;
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.cameraController.value.isInitialized) {
      return Container();
    }

    return Stack(
      children: [
        AspectRatio(
          aspectRatio: widget.cameraController.value.aspectRatio,
          child: CameraPreview(widget.cameraController),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: GestureDetector(
            onTap: () async {
              final XFile? image = await widget.cameraController.takePicture();
              String a = await getImageTotext(image!.path);
              widget.onPictureTaken(a);
            },
            child: const Icon(
              Icons.add_a_photo_rounded,
            ),
          ),
        ),
      ],
    );
  }
}
