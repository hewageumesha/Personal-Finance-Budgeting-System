import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class CameraService {
  final ImagePicker _picker = ImagePicker();

  Future<String?> captureAndSaveReceipt() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70, // Compresses the image to save storage in your DB
    );

    if(photo == null) return null;
    final directory = await getApplicationDocumentsDirectory();
    final String fileName = 'receipt_${DateTime.now().millisecondsSinceEpoch}${path.extension(photo.path)}';
    final String permanentPath = path.join(directory.path, fileName);

    final File savedImage = await File(photo.path).copy(permanentPath);

    return savedImage.path;
  }
}