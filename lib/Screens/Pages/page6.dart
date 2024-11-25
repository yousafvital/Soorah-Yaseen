import 'package:flutter/material.dart';
import 'package:surah_yasin_offline/CustomWidgets/custom_audio_player.dart';

class Page6 extends StatelessWidget {
  final PageController pageController; // Add PageController here
  final bool isManualNavigation;

  const Page6(
      {super.key,
      required this.pageController,
      required this.isManualNavigation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 190,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/w6.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          CustomAudioPlayer(
            audioAsset: 'assets/audios/p6.mp3',
            pageController: pageController,
            isManual: isManualNavigation,
          )
        ],
      ),
    );
  }
}
