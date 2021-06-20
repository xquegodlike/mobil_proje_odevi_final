import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:mobil_dersi_projesi/app/finalkismipages/films_page.dart';
import 'package:mobil_dersi_projesi/utilities/constans.dart';

// ignore: must_be_immutable
class FilmDetailScreen extends StatefulWidget {
  Filmler films;

  FilmDetailScreen({@required this.films});

  @override
  _FilmDetailScreenState createState() => _FilmDetailScreenState();
}

class _FilmDetailScreenState extends State<FilmDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.films.film_ad),
        backgroundColor: backGroundColor,
      ),
      body: Material(
        color: backGroundColor,
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/resimler/${widget.films.film_resim}"),
                  ListTile(
                    leading: Icon(Icons.date_range,color: Colors.white,),
                    title: AnimatedTextKit(
                      pause: Duration(milliseconds: 5000),
                      animatedTexts: [
                        TyperAnimatedText(widget.films.film_yil.toString(),
                            textStyle: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.movie,color: Colors.white,),
                    title: AnimatedTextKit(
                      pause: Duration(milliseconds: 5000),
                      animatedTexts: [
                        TyperAnimatedText(widget.films.directors.yonetmen_ad,
                            textStyle: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.description,color: Colors.white,),
                    title: AnimatedTextKit(
                      pause: Duration(milliseconds: 5000),
                      animatedTexts: [
                        TyperAnimatedText(widget.films.film_aciklama,
                            textStyle: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
