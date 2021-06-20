import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobil_dersi_projesi/common/platform_sens_dialog.dart';
import 'package:mobil_dersi_projesi/core/userviewmodel/user_view_model.dart';
import 'package:mobil_dersi_projesi/utilities/constans.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _controllerUserName;
  File _profilFoto;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _controllerUserName = TextEditingController();
  }

  @override
  void dispose() {
    _controllerUserName.dispose();
    super.dispose();
  }

  void _kameradanFotoCek() async {
    var _yeniResim = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (_yeniResim != null) {
        _profilFoto = File(_yeniResim.path);
      } else {
        print('Resim seçilmedi.');
      }
      Navigator.of(context).pop();
    });
  }

  void _galeridenResimSec() async {
    var _yeniResim = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (_yeniResim != null) {
        _profilFoto = File(_yeniResim.path);
      } else {
        print('Resim seçilmedi.');
      }
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel _userModel = Provider.of<UserViewModel>(context);
    _controllerUserName.text = _userModel.user.userName;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        backgroundColor: backGroundColor,
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton.icon(
            onPressed: () => _cikisIcinOnayIste(context),
            icon: Icon(Icons.exit_to_app,color: Colors.white,),
            label: Text(
              "Çıkış",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
      body: Material(
        color: backGroundColor,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          color: Colors.grey.shade300,
                          height: 160,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.camera),
                                title: Text("Kameradan Çek"),
                                onTap: () {
                                  _kameradanFotoCek();
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.image),
                                title: Text("Galeriden Seç"),
                                onTap: () {
                                  _galeridenResimSec();
                                },
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.white,
                    backgroundImage: _profilFoto == null
                        ? NetworkImage(_userModel.user.profilURL)
                        : FileImage(_profilFoto),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.white,
                initialValue: _userModel.user.email,
                readOnly: true,
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  labelText: "Emailiniz",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.white,
                controller: _controllerUserName,
                decoration: InputDecoration(
                  labelText: "User Name",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child:Text( "Değişiklikleri Kaydet"),
                onPressed: () {
                  _userNameGuncelle(context);
                  _profilFotoGuncelle(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _cikisYap(BuildContext context) async {
    final _userModel = Provider.of<UserViewModel>(context,listen: false);
    bool sonuc = await _userModel.signOut();
    return sonuc;
  }
  Future _cikisIcinOnayIste(BuildContext context) async {
    final sonuc = await PlatformSensDialog(
      baslik: "Emin Misiniz?",
      icerik: "Çıkmak istediğinizden emin misiniz?",
      anaButonYazisi: "Evet",
      iptalButonYazisi: "Vazgeç",
    ).goster(context);

    if (sonuc == true) {
      _cikisYap(context);
    }
  }

  void _userNameGuncelle(BuildContext context) async {
    final _userModel = Provider.of<UserViewModel>(context,listen: false);
    if (_userModel.user.userName != _controllerUserName.text) {
      var updateResult = await _userModel.updateUserName(
          _userModel.user.userID, _controllerUserName.text);

      if (updateResult == true) {
        PlatformSensDialog(
          baslik: "Başarılı",
          icerik: "Username değiştirildi",
          anaButonYazisi: 'Tamam',
        ).goster(context);
      } else {
        _controllerUserName.text = _userModel.user.userName;
        PlatformSensDialog(
          baslik: "Hata",
          icerik: "Username zaten kullanımda, farklı bir username deneyiniz",
          anaButonYazisi: 'Tamam',
        ).goster(context);
      }
    }
  }

  void _profilFotoGuncelle(BuildContext context) async {
    final _userModel = Provider.of<UserViewModel>(context,listen: false);
    if (_profilFoto != null) {
      var url = await _userModel.uploadFile(
          _userModel.user.userID, "profil_foto", _profilFoto);
      //print("gelen url :" + url);

      if (url != null) {
        PlatformSensDialog(
          baslik: "Başarılı",
          icerik: "Profil fotoğrafınız güncellendi",
          anaButonYazisi: 'Tamam',
        ).goster(context);
      }
    }
  }
}
