import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final bool isSelected;

  const CachedImage({Key? key, required this.imageUrl, required this.isSelected, this.radius = 40.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      color: isSelected ? Colors.white : Colors.grey,
      placeholder: (context, url) => CircularProgressIndicator(
        color: Colors.transparent,
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
