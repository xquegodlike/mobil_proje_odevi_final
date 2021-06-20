import 'package:mobil_dersi_projesi/app/finalkismipages/category_page.dart';
import 'package:mobil_dersi_projesi/database_helper.dart';

class Kategorilerdao {
  Future<List<Kategoriler>> tumKategoriler() async {
    var db = await DatabaseHelper.veritabaniErisim();

    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM kategoriler");
    return List.generate(
      maps.length,
      (index) {
        var satir = maps[index];
        return Kategoriler(satir["kategori_id"],satir["kategori_ad"]);
      },
    );
  }
}
