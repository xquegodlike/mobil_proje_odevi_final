import 'package:mobil_dersi_projesi/app/finalkismipages/category_page.dart';

class Diziler{

  // ignore: non_constant_identifier_names
  int dizi_id;
  // ignore: non_constant_identifier_names
  String dizi_ad;
  // ignore: non_constant_identifier_names
  int dizi_yil;
  // ignore: non_constant_identifier_names
  String dizi_resim;
  // ignore: non_constant_identifier_names
  String dizi_aciklama;
  Kategoriler kategori;

  Diziler(this.dizi_id, this.dizi_ad, this.dizi_yil, this.dizi_resim,
      this.dizi_aciklama, this.kategori);
}