import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:whatsapp_camera/camera/camera_whatsapp_controller.dart';
import 'package:whatsapp_camera/camera/images_page.dart';

class WhatsappCamera extends StatefulWidget {
  const WhatsappCamera({super.key});

  @override
  State<WhatsappCamera> createState() => _WhatsappCameraState();
}

class _WhatsappCameraState extends State<WhatsappCamera> {
  final controller = WhatsAppCameraController();
  final painel = SlidingUpPanelController();

  @override
  void dispose() {
    controller.dispose();
    painel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller.inicialize();
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CameraCamera(
              enableZoom: false,
              resolutionPreset: ResolutionPreset.high,
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
          ),
          Positioned(
            bottom: 96,
            left: 0.0,
            right: 0.0,
            child: GestureDetector(
              dragStartBehavior: DragStartBehavior.down,
              onVerticalDragStart: (details) => painel.expand(),
              child: SizedBox(
                height: 120,
                child: Column(
                  children: [
                    if (controller.images.isNotEmpty)
                      const RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.images.length,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            width: 100,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                isAntiAlias: true,
                                filterQuality: FilterQuality.high,
                                image: ThumbnailProvider(
                                  highQuality: true,
                                  mediumId: controller.images[index].id,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: SlidingUpPanelWidget(
              controlHeight: 0,
              panelController: painel,
              child: ImagesPage(
                controller: controller,
                close: painel.hide,
              ),
            ),
          )
        ],
      ),
    );
  }
}
