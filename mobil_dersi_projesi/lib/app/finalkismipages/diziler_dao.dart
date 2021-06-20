import 'package:mobil_dersi_projesi/app/finalkismipages/category_page.dart';
import 'package:mobil_dersi_projesi/app/finalkismipages/diziler_model.dart';
import 'package:mobil_dersi_projesi/database_helper.dart';

class Dizilerdao {
  Future<List<Diziler>> tumDizilerWithKategoriId(int kategori_id) async {
    var db = await DatabaseHelper.veritabaniErisim();

    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM diziler,kategoriler "
            "WHERE diziler.kategori_id = kategoriler.kategori_id and diziler.kategori_id = $kategori_id");
    return List.generate(
      maps.length,
      (index) {
        var satir = maps[index];
        var k = Kategoriler(satir["kategori_id"], satir["kategori_ad"]);
        var d = Diziler(satir["dizi_id"],satir["dizi_ad"],satir["dizi_yil"],
            satir["dizi_resim"], satir["dizi_aciklama"], k);

        return d;
      },
    );
  }
}
