import 'package:flutter/material.dart';
import 'package:mobil_dersi_projesi/app/finalkismipages/category_page.dart';
import 'package:mobil_dersi_projesi/app/finalkismipages/kategoriler_dao.dart';
import 'package:mobil_dersi_projesi/app/finalkismiscreens/film_context_screen.dart';
import 'package:mobil_dersi_projesi/utilities/constans.dart';

class FilmScreen extends StatefulWidget {
  @override
  _FilmScreenState createState() => _FilmScreenState();
}

class _FilmScreenState extends State<FilmScreen> {
  Future<List<Kategoriler>> tumKategorileriGetir() async {
    var kategoriListesi = await Kategorilerdao().tumKategoriler();
    return kategoriListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backGroundColor,
          title: Text("Filmler"),
        ),
        body: Material(
          color: backGroundColor,
          child: FutureBuilder<List<Kategoriler>>(
            future: tumKategorileriGetir(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var kategoriListe = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    var kategori = kategoriListe[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FilmContextScreen(
                              category: kategori,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0,top: 8.0),
                        child: Card(
                          elevation: 6,
                          color: backGroundColor,
                          child: SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(kategori.kategori_ad,style: TextStyle(color: Colors.white),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: kategoriListe.length,
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
