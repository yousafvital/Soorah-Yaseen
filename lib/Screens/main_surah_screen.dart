import 'package:flutter/material.dart';
import 'package:surah_yasin_offline/Screens/Pages/page1.dart';
import 'package:surah_yasin_offline/Screens/Pages/page2.dart';
import 'package:surah_yasin_offline/Screens/Pages/page3.dart';
import 'package:surah_yasin_offline/Screens/Pages/page4.dart';
import 'package:surah_yasin_offline/Screens/Pages/page5.dart';
import 'package:surah_yasin_offline/Screens/Pages/page6.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:surah_yasin_offline/Screens/ayat_by_ayat.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            "assets/images/quran.png",
            width: 42,
            height: 42,
          ),
          onPressed: () {
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
          setState(() {
            _isManualNavigation = true; // Reset autoplay for manual swipes
            firstPageLoaded = true;
          });
        },
        children: [
          Page1(
              pageController: _pageController,
              isManualNavigation: _isManualNavigation,
              autoPlayOnLoad: firstPageLoaded),
          Page2(
              pageController: _pageController,
              isManualNavigation: _isManualNavigation),
          Page3(
              pageController: _pageController,
              isManualNavigation: _isManualNavigation),
          Page4(
              pageController: _pageController,
              isManualNavigation: _isManualNavigation),
          Page5(
              pageController: _pageController,
              isManualNavigation: _isManualNavigation),
          Page6(
              pageController: _pageController,
              isManualNavigation: _isManualNavigation),
        ],
      ),
    );
  }

  void _handlePageChange() {
    if (_pageController.page == _pageController.page!.roundToDouble()) {
      setState(() {
        _isManualNavigation = false; // Automated transitions trigger autoplay
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
