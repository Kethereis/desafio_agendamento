import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final double borderRadius;

  const ImageCard({
    super.key,
    required this.imagePath,
    this.width = 140,
    this.height = 160,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 3),
        child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    )
    );
  }
}
