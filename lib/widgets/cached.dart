import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loader.dart';

class CachedImage extends StatelessWidget {
  String imagePath;
   CachedImage({
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath,fit: BoxFit.cover,
      progressIndicatorBuilder:
          (context, url, downloadProgress) =>
              Loader(),
      errorWidget: (context, url, error) =>
          Icon(Icons.error),
    );
  }
}

