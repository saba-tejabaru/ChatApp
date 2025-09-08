import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerCarousel extends StatelessWidget {
  final List<String> imageUrls;
  final double height;
  final bool autoPlay;
  final double viewportFraction;
  final String? ctaLabel;
  final VoidCallback? onCta;

  const BannerCarousel({
    super.key,
    required this.imageUrls,
    this.height = 180,
    this.autoPlay = true,
    this.viewportFraction = 1,
    this.ctaLabel,
    this.onCta,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: imageUrls.length,
      itemBuilder: (context, index, realIndex) {
        final url = imageUrls[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(url, fit: BoxFit.cover),
              if (ctaLabel != null && onCta != null)
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: ElevatedButton(onPressed: onCta, child: Text(ctaLabel!)),
                ),
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: height,
        enlargeCenterPage: true,
        autoPlay: autoPlay,
        viewportFraction: viewportFraction,
      ),
    );
  }
}

