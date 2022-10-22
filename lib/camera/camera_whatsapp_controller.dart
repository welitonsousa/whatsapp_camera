import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class WhatsAppCameraController extends ChangeNotifier {
  WhatsAppCameraController({
    this.multiple = false,
  });
  final bool multiple;

  List<File> images = [];
  Future<void> openGallery() async {
    final res = await FilePicker.platform.pickFiles(
      allowMultiple: multiple,
      type: FileType.image,
    );
    if (res != null) {
      for (var element in res.files) {
        if (element.path != null) images.add(File(element.path!));
      }
    }
  }

  void captureImage(File file) {}
}
