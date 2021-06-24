import 'package:flutter/material.dart';
import 'package:mobil_dersi_projesi/app/finalkismipages/category_page.dart';
import 'package:mobil_dersi_projesi/app/finalkismipages/filmler_dao.dart';
import 'package:mobil_dersi_projesi/app/finalkismipages/films_page.dart';
import 'package:mobil_dersi_projesi/app/finalkismiscreens/film_detail_screen.dart';
import 'package:mobil_dersi_projesi/utilities/constans.dart';

// ignore: must_be_immutable
class FilmContextScreen extends StatefulWidget {
  Kategoriler category;

  FilmContextScreen({@required this.category});

  @override
  _FilmContextScreenState createState() => _FilmContextScreenState();
}

class _FilmContextScreenState extends State<FilmContextScreen> {
  Future<List<Filmler>> filmleriGoster(int kategori_id) async {
    var filmlerListesi = await Filmlerdao().tumFilmlerWithKategoriId(kategori_id);

    return filmlerListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Filmler : ${widget.category.kategori_ad}"),
          backgroundColor: backGroundColor,
        ),
        body: Material(
          color: backGroundColor,
          child: FutureBuilder<List<Filmler>>(
            future: filmleriGoster(widget.category.kategori_id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var filmListe = snapshot.data;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2 / 3.5),
                  itemBuilder: (context, index) {
                    var film = filmListe[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FilmDetailScreen(films: film,),
                          ),
                        );
                      },
                      child: Card(
                        color: backGroundColor,
                        elevation: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/resimler/${film.film_resim}"),
                            ),
                            Text(
                              film.film_ad,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300,color: Colors.white,),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: filmListe.length,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}
