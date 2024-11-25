import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:share_plus/share_plus.dart';
//import 'package:share_plus/share_plus.dart';
import 'package:surah_yasin_offline/CustomDrawer/menu_items.dart';
import 'package:surah_yasin_offline/CustomDrawer/menu_page.dart';
import 'package:surah_yasin_offline/Screens/about_screen.dart';
import 'package:surah_yasin_offline/Screens/main_surah_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MenuItem currentItem = MenuItems.surah;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ZoomDrawer(
        borderRadius: 40,
        angle: -10,
        slideWidth: MediaQuery.of(context).size.width * 0.8,
        showShadow: true,
        menuBackgroundColor: const Color.fromARGB(255, 176, 151, 61),
        mainScreen: getScreen(),
        isRtl: true,
        mainScreenTapClose: true,
        menuScreenTapClose: true,
        menuScreen: Builder(
          builder: (context) => MenuPage(
            currentItem: currentItem,
            onSelectedItem: (item) {
              setState(() {
                currentItem = item;
                ZoomDrawer.of(context)!.close();
              });
            },
          ),
        ),
      ),
    );
  }

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.about:
        return const AboutScreen();

      case MenuItems.share:
        Share.share('Check out our app on the Play Store: [App Link]');
        return const MainSurahScreen();
      default:
        return const MainSurahScreen();
    }
  }
}
