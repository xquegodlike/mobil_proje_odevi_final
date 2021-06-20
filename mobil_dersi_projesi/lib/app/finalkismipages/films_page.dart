import 'package:mobil_dersi_projesi/app/finalkismipages/category_page.dart';
import 'package:mobil_dersi_projesi/app/finalkismipages/directors_page.dart';

class Filmler{
  // ignore: non_constant_identifier_names
  int film_id;
  // ignore: non_constant_identifier_names
  String film_ad;
  // ignore: non_constant_identifier_names
  int film_yil;
  // ignore: non_constant_identifier_names
  String film_resim;
  // ignore: non_constant_identifier_names
  String film_aciklama;
  Kategoriler categorys;
  Yonetmenler directors;

  Filmler(this.film_id, this.film_ad, this.film_yil, this.film_resim,
      this.film_aciklama, this.categorys, this.directors);
}