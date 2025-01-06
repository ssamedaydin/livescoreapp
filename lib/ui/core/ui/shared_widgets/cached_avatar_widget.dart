import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const CachedAvatar({Key? key, required this.imageUrl, this.radius = 40.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: CachedNetworkImageProvider(imageUrl),
      onBackgroundImageError: (exception, stackTrace) {
        debugPrint('Image load error: $exception');
      },
      backgroundColor: Colors.grey[200],
    );
  }
}
