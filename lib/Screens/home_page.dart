import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
//import 'package:share_plus/share_plus.dart';
import 'package:surah_yasin_offline/CustomDrawer/menu_items.dart';
import 'package:surah_yasin_offline/CustomDrawer/menu_page.dart';
import 'package:surah_yasin_offline/Screens/about_screen.dart';
import 'package:surah_yasin_offline/Screens/main_surah_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MenuItem currentItem = MenuItems.surah;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        borderRadius: 40,
        angle: -10,
        slideWidth: MediaQuery.of(context).size.width * 0.8,
        showShadow: true,
        menuBackgroundColor: const Color.fromARGB(255, 176, 151, 61),
        mainScreen: getScreen(),
        isRtl: true,
        menuScreen: MenuPage(
          currentItem: currentItem,
          onSelectedItem: (item) async {
            setState(() {
              currentItem = item;
            });

            // Close the drawer
            ZoomDrawer.of(context)?.close();

            // If "share" is selected, trigger sharing
            if (item == MenuItems.share) {
              // await Share.share(
              //     'Check out our app on the Play Store: [App Link]');
              // Set the screen to MainSurahScreen after sharing
              setState(() {
                currentItem = MenuItems.surah;
              });
            }
          },
        ),
      ),
    );
  }

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.about:
        return const AboutScreen();
      default:
        return MainSurahScreen();
    }
  }
}
