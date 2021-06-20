import 'package:flutter/material.dart';
import 'package:mobil_dersi_projesi/utilities/constans.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hakkımızda"),
        backgroundColor: backGroundColor,
      ),
      body: Material(
        color: backGroundColor,
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: backGroundColor,
          padding: EdgeInsets.only(top: 16,left: 6,right: 6),
          child: Text(
            "Bu uygulama Dr. Öğretim Üyesi Ahmet Cevahir ÇINAR tarafından yürütülen 3311409 kodlu "
                "Mobil Programlama dersi kapsamında 173311052 numaralı Mustafa Fatih GÜNDÜZ tarafından "
                "25 Haziran 2021 günü yapılmıştır.",
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 16,
                fontFamily: "OpenSans",color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
