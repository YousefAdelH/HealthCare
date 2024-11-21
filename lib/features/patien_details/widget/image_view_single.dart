import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class OneImageViewer {
  OneImageViewer(BuildContext context, images) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.8),
      transitionDuration: Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: 'Image Viewer',
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Hero(
            tag: 'IMAGEVIEW',
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Scaffold(
                backgroundColor: Colors.black,
                body: Container(
                    color: Colors.black,
                    child: Center(
                      child: PhotoView(
                        imageProvider: NetworkImage(images),
                        backgroundDecoration:
                            BoxDecoration(color: Colors.black),
                        loadingBuilder: (context, event) => Center(
                          child: CircularProgressIndicator(
                            value: event == null
                                ? null
                                : event.cumulativeBytesLoaded /
                                    (event.expectedTotalBytes ?? 1),
                          ),
                        ),
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.broken_image, color: Colors.white),
                      ),
                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}