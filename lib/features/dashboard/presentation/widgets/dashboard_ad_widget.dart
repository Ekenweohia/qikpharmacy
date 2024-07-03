import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AdWidget extends StatelessWidget {
  const AdWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 160,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2,
      ),
      items: [
        adItem('assets/images/drugs.png'),
        adItem('assets/images/nose_mask.png'),
        adItem('assets/images/pharma.png')
      ],
    );
  }

  Widget adItem(String image) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(image),
          ),
        ),
      );
}
