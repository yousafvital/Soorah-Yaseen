import 'package:flutter/material.dart';
import 'package:surah_yasin_offline/CustomWidgets/custom_audio_player.dart';

class Page1 extends StatefulWidget {
  final PageController pageController;
  final bool isManualNavigation;
  final bool autoPlayOnLoad;

  const Page1({
    super.key,
    required this.pageController,
    required this.isManualNavigation,
    required this.autoPlayOnLoad,
  });

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Background image with zoom functionality
          Expanded(
            child: InteractiveViewer(
              clipBehavior: Clip.none,
              panEnabled: false,
              minScale: 1,
              maxScale: 3,
              child: Image.asset(
                'assets/images/w1.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Custom audio player
          CustomAudioPlayer(
            audioAsset: 'assets/audios/p1.mp3',
            pageController: widget.pageController,
            isManual: widget.autoPlayOnLoad && widget.isManualNavigation,
          ),
        ],
      ),
    );
  }
}
