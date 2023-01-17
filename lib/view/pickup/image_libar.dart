import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// ignore: must_be_immutable
class ImageLib extends StatefulWidget {
  ImageLib({Key? key, required this.galleryItems, required this.idex})
      : super(key: key);
  final List galleryItems;
  int idex;

  @override
  State<ImageLib> createState() => _ImageLibState();
}

class _ImageLibState extends State<ImageLib> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 30, top: 20),
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.clear,
              size: 35,
              color: whiteColor,
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: PhotoViewGallery.builder(
                enableRotation: true,
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(
                          widget.galleryItems[widget.idex].image.toString()),
                      maxScale: PhotoViewComputedScale.contained * 4,
                      minScale: PhotoViewComputedScale.contained
                      //   heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index]),
                      );
                },
                itemCount: widget.galleryItems.length,
                onPageChanged: (i) => setState(() {
                  widget.idex = i;
                }),
              )),
          CustomText(
            text: "${widget.idex + 1}/${widget.galleryItems.length}",
            alignment: Alignment.bottomCenter,
            size: 18,
            color: whiteColor,
          )
        ],
      ),
    );
  }
}
