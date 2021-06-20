import 'package:mobil_dersi_projesi/app/finalkismipages/category_page.dart';
import 'package:mobil_dersi_projesi/app/finalkismipages/directors_page.dart';
import 'package:mobil_dersi_projesi/app/finalkismipages/films_page.dart';
import 'package:mobil_dersi_projesi/database_helper.dart';

class Filmlerdao{
  Future<List<Filmler>> tumFilmlerWithKategoriId(int kategori_id) async {
    var db = await DatabaseHelper.veritabaniErisim();

    List<Map<String, dynamic>> maps =
    await db.rawQuery("SELECT * FROM filmler,kategoriler,yonetmenler "
        "WHERE filmler.kategori_id = kategoriler.kategori_id "
        "and filmler.yonetmen_id = yonetmenler.yonetmen_id and filmler.kategori_id = $kategori_id");
    return List.generate(
      maps.length,
          (index) {
        var satir = maps[index];
        
        var k = Kategoriler(satir["kategori_id"],satir["kategori_ad"]);
        var y = Yonetmenler(satir["yonetmen_id"],satir["yonetmen_ad"]);
        var f = Filmler(satir["film_id"],satir["film_ad"],satir["film_yil"],satir["film_resim"],satir["film_aciklama"], k, y);
        return f;
      },
    );
  }
}