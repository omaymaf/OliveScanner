import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _openCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        // Here you can handle the image, e.g., display it or send it for analysis.
        // For demonstration, we'll just print the path.
        print('Image path: ${image.path}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Olivier Scanner'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _openCamera,
          child: Text('Scanner les Olives'),
        ),
      ),
    );
  }
}
