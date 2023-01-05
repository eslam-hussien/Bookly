import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../models/bookly_model.dart';
class ImageSlider extends StatelessWidget {
  const ImageSlider({
    Key? key,
    required this.eventData,
  }) : super(key: key);

  final BooklyModel? eventData;

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      /// Width of the [ImageSlideshow].
      width: MediaQuery.of(context).size.width,

      /// Height of the [ImageSlideshow].
      height: 284,

      /// The page to show when first creating the [ImageSlideshow].
      initialPage: 0,

      /// The color to paint the indicator.
      indicatorColor: Colors.blue,

      /// The color to paint behind th indicator.
      indicatorBackgroundColor: Colors.grey,

      /// Auto scroll interval.
      /// Do not auto scroll with null or 0.
      autoPlayInterval: 3000,

      /// Loops back to first slide.
      isLoop: true,

      /// The widgets to display in the [ImageSlideshow].
      /// Add the sample image file into the images folder
      children: [
        for (int i = 0; i < eventData!.img.length; i++)
          eventData!.img[i] == null
              ? Image.network(eventData!.img[i])
              : Image.asset(
            'assets/images/img0.jpg',
            fit: BoxFit.cover,
          )
      ],
    );
  }
}