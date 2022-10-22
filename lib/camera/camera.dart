import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_camera/camera/camera_whatsapp_controller.dart';

class WhatsappCamera extends StatefulWidget {
  const WhatsappCamera({super.key});

  @override
  State<WhatsappCamera> createState() => _WhatsappCameraState();
}

class _WhatsappCameraState extends State<WhatsappCamera> {
  final controller = WhatsAppCameraController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: CameraCamera(
              enableZoom: false,
              onFile: controller.captureImage,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  color: Colors.white,
                  onPressed: (() => Navigator.pop(context)),
                  icon: const Icon(Icons.close),
                ),
                IconButton(
                  color: Colors.white,
                  onPressed: controller.openGallery,
                  icon: const Icon(Icons.image),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
