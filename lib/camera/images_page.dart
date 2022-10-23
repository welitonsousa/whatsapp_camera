import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:whatsapp_camera/camera/camera_whatsapp_controller.dart';

class ImagesPage extends StatefulWidget {
  final WhatsAppCameraController controller;
  final void Function()? close;
  const ImagesPage({super.key, required this.controller, this.close});

  @override
  State<ImagesPage> createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height - 40,
      child: Column(
        children: [
          Container(
            height: 40,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: widget.close?.call,
                  icon: const Icon(Icons.close),
                ),
                Text(widget.controller.images.length.toString()),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.check),
                )
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              itemCount: widget.controller.images.length,
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 140,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 4),
              ),
              itemBuilder: (context, index) {
                return _ImageItem(
                  image: widget.controller.images[index].id,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageItem extends StatelessWidget {
  final String image;
  const _ImageItem({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          image: ThumbnailProvider(
            mediumId: image,
            highQuality: true,
            height: 150,
            width: 150,
            mediumType: MediumType.image,
          ),
        ),
      ),
    );
  }
}
