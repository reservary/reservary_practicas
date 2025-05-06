import 'package:flutter/material.dart';

class ImageExample extends StatelessWidget {
  const ImageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network("https://static.vecteezy.com/system/resources/thumbnails/034/616/588/small_2x/accept-button-3d-illustration-png.png"),
        Image.asset("assets/images/accept.jpg",height: 100,fit: BoxFit.fill),
      ],
    );
  }
}