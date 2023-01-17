import 'package:cached_network_image/cached_network_image.dart';
import 'package:dalile_customer/components/generalModel.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert imageViewModal(BuildContext context, {required String imagePath}) {
  return modal(
      context,
      Column(
        children: [
          Center(
              child: InteractiveViewer(
            // boundaryMargin: EdgeInsets.all(100),
            minScale: 1,
            maxScale: 3,
            child: CachedNetworkImage(
              imageUrl: imagePath,
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.7,
              fit: BoxFit.contain,
              placeholder: (context, url) => Text(''),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          )),
        ],
      ));
}
