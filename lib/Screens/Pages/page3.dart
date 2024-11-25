import 'package:flutter/material.dart';
import 'package:surah_yasin_offline/CustomWidgets/custom_audio_player.dart';
import 'package:widget_zoom/widget_zoom.dart';

class Page3 extends StatelessWidget {
  final PageController pageController; // Add PageController here
  final bool isManualNavigation;

  const Page3(
      {super.key,
      required this.pageController,
      required this.isManualNavigation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Background image with zoom functionality
          Expanded(
            child: WidgetZoom(
              heroAnimationTag: 'tag',
              zoomWidget: Image.asset(
                'assets/images/w3.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Custom audio player
          CustomAudioPlayer(
            audioAsset: 'assets/audios/p3.mp3',
            pageController: pageController,
            isManual: isManualNavigation,
          ),
        ],
      ),
    );
  }
}
