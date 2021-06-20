import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { AnaSayfa, TV, Film, Profil }

class TabItemData {
  final String title;
  final IconData icon;

  TabItemData(this.title, this.icon);

  static Map<TabItem, TabItemData> tumTablar = {
    TabItem.AnaSayfa:
    TabItemData("AnaSayfa", Icons.home),
    TabItem.TV: TabItemData("TV", Icons.tv),
    TabItem.Film: TabItemData("Film", Icons.movie_creation_outlined),
    TabItem.Profil: TabItemData("Profil", Icons.person),
  };
}
