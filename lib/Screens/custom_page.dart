import 'package:flutter/material.dart';
import 'package:surah_yasin_offline/CustomWidgets/custom_audio_player.dart';

class CustomPage extends StatelessWidget {
  final String imagePath;
  final String audioPath;
  final PageController pageController;
  final bool isManualNavigation;
  final bool autoPlayOnLoad;
  final bool isLastPage; // Flag to indicate if it's the last page

  const CustomPage({
    required this.imagePath,
    required this.audioPath,
    required this.pageController,
    required this.isManualNavigation,
    this.autoPlayOnLoad = false,
    this.isLastPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Image display with conditional height
        isLastPage
            ? SizedBox(
                height: 200,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                ),
              )
            : Expanded(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                ),
              ),

        // Audio Player
        CustomAudioPlayer(
          audioAsset: audioPath,
          pageController: pageController,
          isManual: isManualNavigation,
        ),
      ],
    );
  }
}
