import 'package:flutter/material.dart';
import 'package:ilkproje/screens/components/formlar.dart';
import 'package:ilkproje/screens/components/widgets.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProfilBilgileri extends StatefulWidget {
  @override
  _ProfilBilgileriState createState() => _ProfilBilgileriState();
}

class _ProfilBilgileriState extends State<ProfilBilgileri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: ProfilForm(),
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    title: Text(
      "Kayıt Ol",
      style: TextStyle(
          color: kPrimaryColor, fontSize: yuksekligeGoreAyarla(context, 27)),
    ),
    leading: IconButton(
      color: kPrimaryColor,
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => {Navigator.pop(context)},
    ),
  );
}

class ProfilForm extends StatefulWidget {
  @override
  _ProfilFormState createState() => _ProfilFormState();
}

class _ProfilFormState extends State<ProfilForm> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(1),
        child: Column(
          children: <Widget>[
            SizedBox(height: yuksekligeGoreAyarla(context, 40)),
            Text(
              "Profili Tamamla",
              style: TextStyle(
                color: Colors.black,
                fontSize: yuksekligeGoreAyarla(context, 28),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: yuksekligeGoreAyarla(context, 60)),
            ProfilFormElemanlari(),
          ],
        ),
      ),
    );
  }
}

class ProfilFormElemanlari extends StatefulWidget {
  @override
  _ProfilFormElemanlariState createState() => _ProfilFormElemanlariState();
}

class _ProfilFormElemanlariState extends State<ProfilFormElemanlari> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: genisligeGoreAyarla(context, 24)),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                    child: Column(
                  children: [
                    buildKullaniciAdi(context),
                    SizedBox(
                      height: yuksekligeGoreAyarla(context, 20),
                    ),
                    buildAd(context),
                    SizedBox(
                      height: yuksekligeGoreAyarla(context, 20),
                    ),
                    buildSoyad(context),
                    SizedBox(
                      height: yuksekligeGoreAyarla(context, 30),
                    ),
                  ],
                )),
                Column(
                  children: [
                    Button(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilBilgileri()),
                          );
                        }
                      },
                      title: "Kaydı Tamamla",
                      buttonColor: kPrimaryColor,
                      fontColor: Colors.white,
                      fontSize: yuksekligeGoreAyarla(context, 21),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
