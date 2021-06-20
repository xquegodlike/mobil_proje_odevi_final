import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:mobil_dersi_projesi/app/finalkismipages/diziler_model.dart';
import 'package:mobil_dersi_projesi/utilities/constans.dart';

// ignore: must_be_immutable
class TelevisionDetailScreen extends StatefulWidget {
  Diziler dizi;

  TelevisionDetailScreen({@required this.dizi});

  @override
  _TelevisionDetailScreenState createState() => _TelevisionDetailScreenState();
}

class _TelevisionDetailScreenState extends State<TelevisionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.dizi.dizi_ad),
          backgroundColor: backGroundColor,
        ),
        body: Material(
          color: backGroundColor,
          child: ListView(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("assets/resimler/${widget.dizi.dizi_resim}"),
                    ListTile(
                      leading: Icon(Icons.date_range,color: Colors.white,),
                      title: AnimatedTextKit(
                        pause: Duration(milliseconds: 5000),
                        animatedTexts: [
                          TyperAnimatedText(widget.dizi.dizi_yil.toString(),
                              textStyle: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.description,color: Colors.white,),
                      title: AnimatedTextKit(
                        stopPauseOnTap: true,
                        totalRepeatCount: 1,
                        animatedTexts: [
                          TyperAnimatedText(widget.dizi.dizi_aciklama,
                              textStyle: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
