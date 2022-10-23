import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

enum ImageType { file, network, asset }

class ViewImage extends StatefulWidget {
  final String image;
  final ImageType imageType;
  const ViewImage({
    super.key,
    required this.image,
    this.imageType = ImageType.file,
  });

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  final opacity = ValueNotifier(1.0);

  @override
  void dispose() {
    opacity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Dismissible(
              key: Key(widget.image),
              direction: DismissDirection.vertical,
              confirmDismiss: (direction) async {
                Navigator.pop(context);
                return true;
              },
              onUpdate: (v) {
                double value = 1 - (v.progress * 2);
                if (value < 0) value = 0;
                opacity.value = value;
              },
              child: AnimatedBuilder(
                animation: opacity,
                builder: (context, child) {
                  return Opacity(
                    opacity: opacity.value,
                    child: Hero(
                      tag: widget.image,
                      child: PhotoView(
                        imageProvider: imageProvider,
                        maxScale: 3.0,
                        minScale: MediaQuery.of(context).size.aspectRatio,
                      ),
                    ),
                  );
                },
              ),
            ),
            const CloseButton(color: Colors.white),
          ],
        ),
      ),
    );
  }

  ImageProvider get imageProvider {
    if (widget.imageType == ImageType.file) {
      return FileImage(File(widget.image));
    } else if (widget.imageType == ImageType.network) {
      return NetworkImage(widget.image);
    } else {
      return AssetImage(widget.image);
    }
  }
}
