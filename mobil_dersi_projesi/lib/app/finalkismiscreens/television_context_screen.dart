import 'package:flutter/material.dart';
import 'package:mobil_dersi_projesi/app/finalkismipages/category_page.dart';
import 'package:mobil_dersi_projesi/app/finalkismipages/diziler_dao.dart';
import 'package:mobil_dersi_projesi/app/finalkismipages/diziler_model.dart';
import 'package:mobil_dersi_projesi/app/finalkismiscreens/television_detail_screen.dart';
import 'package:mobil_dersi_projesi/utilities/constans.dart';

// ignore: must_be_immutable
class TelevisionContextScreen extends StatefulWidget {
  Kategoriler category;

  TelevisionContextScreen({@required this.category});

  @override
  _TelevisionContextScreenState createState() =>
      _TelevisionContextScreenState();
}

class _TelevisionContextScreenState extends State<TelevisionContextScreen> {
  Future<List<Diziler>> dizileriGoster(int kategori_id) async {
    var dizilerListesi =
        await Dizilerdao().tumDizilerWithKategoriId(kategori_id);
    return dizilerListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diziler : ${widget.category.kategori_ad}"),
        backgroundColor: backGroundColor,
      ),
      body: Material(
        color: backGroundColor,
        child: FutureBuilder<List<Diziler>>(
          future: dizileriGoster(widget.category.kategori_id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var diziListe = snapshot.data;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2 / 3.5),
                itemBuilder: (context, index) {
                  var dizi = diziListe[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TelevisionDetailScreen(
                            dizi: dizi,
                          ),
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
                            child:
                                Image.asset("assets/resimler/${dizi.dizi_resim}"),
                          ),
                          Text(
                            dizi.dizi_ad,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300,color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: diziListe.length,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
