import 'package:flutter/material.dart';
import 'package:surah_yasin_offline/CustomDrawer/top_nav_bar_dp.dart';

import 'menu_items.dart';

class MenuItems {
  static const surah = MenuItem('Surah', Icons.book);
  static const about = MenuItem('About Us', Icons.info);
  static const share = MenuItem('Share', Icons.share);
  // static const rateUS = MenuItem('Rate Us', Icons.star_border);

  static const all = <MenuItem>[surah, about, share];
}

class MenuPage extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  const MenuPage({
    super.key,
    required this.currentItem,
    required this.onSelectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 176, 151, 61),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30),
              const UserProfile(),
              const SizedBox(height: 30),
              ...MenuItems.all.map(buildMenuItem),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(MenuItem item) => ListTileTheme(
        selectedColor: const Color.fromARGB(255, 0, 0, 0),
        child: ListTile(
          selectedTileColor: const Color.fromARGB(123, 255, 255, 255),
          selected: currentItem == item,
          minLeadingWidth: 20,
          leading: Icon(
            item.icon,
            color: Colors.black,
          ),
          title: Text(
            item.title,
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          onTap: () => onSelectedItem(item),
        ),
      );
}
