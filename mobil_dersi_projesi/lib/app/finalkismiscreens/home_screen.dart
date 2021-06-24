import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobil_dersi_projesi/app/finalkismiscreens/film_screen.dart';
import 'package:mobil_dersi_projesi/app/finalkismiscreens/profile_screen.dart';
import 'package:mobil_dersi_projesi/app/finalkismiscreens/television_screen.dart';
import 'package:mobil_dersi_projesi/app/screens/about_screen.dart';
import 'package:mobil_dersi_projesi/core/userviewmodel/user_view_model.dart';
import 'package:mobil_dersi_projesi/utilities/constans.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  double ekranYuksekligi, ekranGenisligi;
  bool menuAcikMi = false;
  AnimationController _animationController;
  Animation<double> _scaleAnimation;
  Animation<Offset> _menuOffsetAnimation;
  Duration _duration = Duration(milliseconds: 500);

  Map<String, double> odulAlanEnFazlaKategori = {
    "Aksiyon": 5,
    "Drama": 11,
    "Bilim Kurgu": 6,
    "Komedi": 11,
    "Romantik" : 5,
    "Gerilim" : 5
  };

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _duration);
    _scaleAnimation = Tween(begin: 1.0, end: 0.6).animate(_animationController);
    _menuOffsetAnimation = Tween(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ekranYuksekligi = MediaQuery.of(context).size.height;
    ekranGenisligi = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backGroundColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            menuOlustur(context),
            dashboardOlustur(context),
          ],
        ),
      ),
    );
  }

  Widget menuOlustur(BuildContext context) {
    UserViewModel _userModel = Provider.of<UserViewModel>(context);
    return SlideTransition(
      position: _menuOffsetAnimation,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: _userModel.user.profilURL != null
                          ? NetworkImage(_userModel.user.profilURL)
                          : Image.asset("assets/resimler/her.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          Text(
                            "${_userModel.user.userName}",
                            style: TextStyle(color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                          ),
                          Text(
                            "${_userModel.user.email}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // ignore: deprecated_member_use
              FlatButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.home,
                  color: Colors.purple,
                ),
                label: Text(
                  "Anasayfa",
                  style: menuTextStyle,
                ),
              ),
              // ignore: deprecated_member_use
              FlatButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TelevisionScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.tv, color: Colors.purple),
                label: Text(
                  "Diziler",
                  style: menuTextStyle,
                ),
              ),
              // ignore: deprecated_member_use
              FlatButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FilmScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.movie_creation, color: Colors.purple),
                label: Text(
                  "Filmler",
                  style: menuTextStyle,
                ),
              ),
              // ignore: deprecated_member_use
              FlatButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.account_circle_sharp, color: Colors.purple),
                label: Text(
                  "Profil",
                  style: menuTextStyle,
                ),
              ),
              // ignore: deprecated_member_use
              FlatButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AboutScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.insert_drive_file, color: Colors.purple),
                label: Text(
                  "Hakkında",
                  style: menuTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dashboardOlustur(BuildContext context) {
    return AnimatedPositioned(
      duration: _duration,
      top: 0,
      bottom: 0,
      left: menuAcikMi ? ekranGenisligi * 0.5 : 0,
      right: menuAcikMi ? ekranGenisligi * -0.4 : 0,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          elevation: 8,
          color: backGroundColor,
          borderRadius:
              menuAcikMi ? BorderRadius.all(Radius.circular(30)) : null,
          child: SingleChildScrollView(

            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            if (menuAcikMi) {
                              _animationController.reverse();
                            } else {
                              _animationController.forward();
                            }
                            menuAcikMi = !menuAcikMi;
                          });
                        },
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        )),
                    Text(
                      "Anasayfa",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Opacity(
                      opacity: 0,
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      height: ekranYuksekligi * 0.5,
                      width: ekranGenisligi,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: PageView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Image.asset("assets/resimler/her.png"),
                                Image.asset("assets/resimler/argo.png"),
                                Image.asset("assets/resimler/blackmirror.png"),
                                Image.asset("assets/resimler/artist.png"),
                                Image.asset("assets/resimler/astarisborn.png"),
                                Image.asset("assets/resimler/hollywood.png"),
                                Image.asset("assets/resimler/lost.png"),
                                Image.asset("assets/resimler/moonlight.png"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Sevebileceğini Düşündüğümüz Bazı Film Ve Diziler",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16),),
                          ),
                          Divider(color: Colors.grey.shade600,),
                        ],
                      ),
                    ),
                    Text("En Fazla Ödül Alan Kategoriler",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16),),
                    PieChart(
                      dataMap: odulAlanEnFazlaKategori,
                      animationDuration: Duration(milliseconds: 800),
                      chartLegendSpacing: 32,
                      chartRadius: ekranGenisligi * 1/2,
                      initialAngleInDegree: 0,
                      chartType: ChartType.disc,
                      ringStrokeWidth: 32,
                      centerText: "Kategoriler",
                      legendOptions: LegendOptions(
                        showLegendsInRow: false,
                        legendPosition: LegendPosition.right,
                        showLegends: true,
                        legendTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      chartValuesOptions: ChartValuesOptions(
                        showChartValueBackground: true,
                        showChartValues: true,
                        showChartValuesInPercentage: false,
                        showChartValuesOutside: false,
                        decimalPlaces: 0,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
