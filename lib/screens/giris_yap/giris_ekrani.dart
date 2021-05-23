import 'package:flutter/material.dart';
import 'package:ilkproje/screens/giris_yap/components/body.dart';
import '../../constants.dart';
import '../../size_config.dart';

class GirisEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(context),
      body: Body(),
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 0,
    title: Text(
      "Giriş Yap",
      style: TextStyle(
          color: kPrimaryColor,
          fontWeight: FontWeight.w500,
          fontSize: yuksekligeGoreAyarla(context, 27)),
    ),
  );
}
