import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:whatsapp_camera/camera/camera_whatsapp_controller.dart';
import 'package:whatsapp_camera/camera/view_image.dart';

class ImagesPage extends StatefulWidget {
  final WhatsAppCameraController controller;
  final void Function()? close;
  final void Function()? done;
  const ImagesPage({
    super.key,
    required this.controller,
    this.close,
    this.done,
  });

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
                if (widget.controller.multiple)
                  Text(widget.controller.selectedImages.length.toString()),
                IconButton(
                  onPressed: widget.done?.call,
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
                return InkWell(
                  onTap: () => widget.controller
                      .selectImage(widget.controller.images[index]),
                  child: ImageItem(
                    selected: widget.controller.imageIsSelected(
                      widget.controller.images[index].filename,
                    ),
                    image: widget.controller.images[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ImageItem extends StatelessWidget {
  final Medium image;
  final bool selected;
  const ImageItem({super.key, required this.image, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          Hero(
            tag: image.id,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  image: ThumbnailProvider(
                    mediumId: image.id,
                    highQuality: true,
                    height: 150,
                    width: 150,
                    mediumType: MediumType.image,
                  ),
                ),
              ),
            ),
          ),
          if (selected)
            Container(
              color: Colors.grey.withOpacity(.3),
              child: Center(
                child: Stack(
                  children: [
                    const Icon(
                      Icons.done,
                      size: 52,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.done,
                      size: 50,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              color: Colors.white,
              icon: const Icon(Icons.zoom_out_map_outlined),
              onPressed: () async {
                image.getFile().then((value) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return Hero(
                        tag: image.id,
                        child: ViewImage(image: value.path),
                      );
                    },
                  ));
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
