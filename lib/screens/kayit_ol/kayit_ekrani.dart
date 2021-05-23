import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'components/body.dart';

class KayitEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    leading: IconButton(
      color: kPrimaryColor,
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => {Navigator.pop(context)},
    ),
    title: Text(
      "Kayıt Ol",
      style: TextStyle(
          color: kPrimaryColor,
          fontWeight: FontWeight.w500,
          fontSize: yuksekligeGoreAyarla(context, 27)),
    ),
  );
}
