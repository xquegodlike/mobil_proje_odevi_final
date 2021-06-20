import 'package:flutter/material.dart';
import 'package:mobil_dersi_projesi/app/finalkismiscreens/film_screen.dart';
import 'package:mobil_dersi_projesi/app/finalkismiscreens/home_screen.dart';
import 'package:mobil_dersi_projesi/app/finalkismiscreens/profile_screen.dart';
import 'package:mobil_dersi_projesi/app/finalkismiscreens/television_screen.dart';
import 'package:mobil_dersi_projesi/common/my_custom_bottom_navi.dart';
import 'package:mobil_dersi_projesi/core/usermodel/user_model.dart';
import 'package:mobil_dersi_projesi/core/userviewmodel/user_view_model.dart';
import 'package:mobil_dersi_projesi/utilities/tab_items.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final UserModel user;

  HomePage({Key key, @required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  TabItem _currentTab = TabItem.AnaSayfa;

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.AnaSayfa: GlobalKey<NavigatorState>(),
    TabItem.TV: GlobalKey<NavigatorState>(),
    TabItem.Film: GlobalKey<NavigatorState>(),
    TabItem.Profil: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, Widget> tumSayfalar() {
    return {
      TabItem.AnaSayfa: ChangeNotifierProvider(
        create: (context) => UserViewModel(),
        child: HomeScreen(),
      ),
      TabItem.TV: TelevisionScreen(),
      TabItem.Film: FilmScreen(),
      TabItem.Profil: ProfileScreen(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
      !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: MyCustomBottomNavigation(
        sayfaOlusturucu: tumSayfalar(),
        navigatorKeys: navigatorKeys,
        currentTab: _currentTab,
        onSelectedTab: (secilenTab) {

          if (secilenTab == _currentTab) {
            navigatorKeys[secilenTab]
                .currentState
                .popUntil((route) => route.isFirst);
          } else {
            setState(() {
              _currentTab = secilenTab;
            });
          }
        },
      ),
    );
  }
}