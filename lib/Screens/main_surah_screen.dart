import 'package:flutter/material.dart';
import 'package:surah_yasin_offline/CustomWidgets/custom_audio_player.dart';
import 'package:surah_yasin_offline/Screens/Pages/page1.dart';
import 'package:surah_yasin_offline/Screens/Pages/page2.dart';
import 'package:surah_yasin_offline/Screens/Pages/page3.dart';
import 'package:surah_yasin_offline/Screens/Pages/page4.dart';
import 'package:surah_yasin_offline/Screens/Pages/page5.dart';
import 'package:surah_yasin_offline/Screens/Pages/page6.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:surah_yasin_offline/Screens/ayat_by_ayat.dart';
import 'package:surah_yasin_offline/Screens/custom_page.dart';

class MainSurahScreen extends StatefulWidget {
  const MainSurahScreen({super.key});

  @override
  State<MainSurahScreen> createState() => _MainSurahScreenState();
}

class _MainSurahScreenState extends State<MainSurahScreen> {
  final PageController _pageController = PageController();
  bool _isManualNavigation = false;
  bool firstPageLoaded = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_handlePageChange);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> pagesData = [
      {"image": "assets/images/w1.jpg", "audio": "assets/audios/p1.mp3"},
      {"image": "assets/images/w2.jpg", "audio": "assets/audios/p2.mp3"},
      {"image": "assets/images/w3.jpg", "audio": "assets/audios/p3.mp3"},
      {"image": "assets/images/w4.jpg", "audio": "assets/audios/p4.mp3"},
      {"image": "assets/images/w5.jpg", "audio": "assets/audios/p5.mp3"},
      {"image": "assets/images/w6.png", "audio": "assets/audios/p6.mp3"},
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            "assets/images/quran.png",
            width: 42,
            height: 42,
          ),
          onPressed: () {
            if (mounted) {
              CustomAudioPlayer.stopAllAudio(); // Stops all audio
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AyatByAyatScreen()),
            );
          },
        ),
        title: const Text(
          'سُورَة يٰسٓ',
          style: TextStyle(
            color: Color.fromARGB(255, 176, 151, 61),
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Noori',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              ZoomDrawer.of(context)?.toggle();
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        reverse: true,
        onPageChanged: (index) {
          if (mounted) {
            CustomAudioPlayer.stopAllAudio(); // Stops all audio
          }
          setState(() {
            _isManualNavigation = true;
            firstPageLoaded = true;
          });
        },
        children: pagesData.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, String> page = entry.value;

          return CustomPage(
            imagePath: page["image"]!,
            audioPath: page["audio"]!,
            pageController: _pageController,
            isManualNavigation: _isManualNavigation,
            autoPlayOnLoad: firstPageLoaded,
            isLastPage: index == pagesData.length - 1, // Pass true if last page
          );
        }).toList(),
      ),
    );
  }

  void _handlePageChange() {
    if (_pageController.page == _pageController.page!.roundToDouble()) {
      setState(() {
        _isManualNavigation = false;
      });
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_handlePageChange);
    _pageController.dispose();
    super.dispose();
  }
}
