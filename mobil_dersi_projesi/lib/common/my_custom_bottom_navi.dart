import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobil_dersi_projesi/utilities/constans.dart';
import 'package:mobil_dersi_projesi/utilities/tab_items.dart';

class MyCustomBottomNavigation extends StatefulWidget {
  const MyCustomBottomNavigation(
      {Key key,
        @required this.currentTab,
        @required this.onSelectedTab,
        @required this.sayfaOlusturucu,
        @required this.navigatorKeys})
      : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem, Widget> sayfaOlusturucu;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  _MyCustomBottomNavigationState createState() =>
      _MyCustomBottomNavigationState();
}

class _MyCustomBottomNavigationState extends State<MyCustomBottomNavigation> {

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: backGroundColor,
      tabBar: CupertinoTabBar(
        backgroundColor: backGroundColor,
        activeColor: Colors.white,
        inactiveColor: Colors.grey.shade700,
        items: [
          _navItemOlustur(TabItem.AnaSayfa),
          _navItemOlustur(TabItem.TV),
          _navItemOlustur(TabItem.Film),
          _navItemOlustur(TabItem.Profil),
        ],
        onTap: (index) => widget.onSelectedTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final gosterilecekItem = TabItem.values[index];
        return CupertinoTabView(
            navigatorKey: widget.navigatorKeys[gosterilecekItem],
            builder: (context) {
              return widget.sayfaOlusturucu[gosterilecekItem];
            });
      },
    );
  }

  BottomNavigationBarItem _navItemOlustur(TabItem tabItem) {
    final olusturulacakTab = TabItemData.tumTablar[tabItem];

    return BottomNavigationBarItem(
      icon: Icon(olusturulacakTab.icon),
      label: olusturulacakTab.title,
    );
  }
}