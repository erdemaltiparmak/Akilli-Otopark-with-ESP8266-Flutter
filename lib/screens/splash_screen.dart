import 'package:flutter/material.dart';
import 'package:ilkproje/constants.dart';
import 'package:ilkproje/main.dart';

import 'package:ilkproje/utils/shared_preferences.dart';

import '../size_config.dart';
import 'giris_yap/giris_ekrani.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _SplashScreenState();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2, milliseconds: 50), () {
      getSharedPreferences().then((value) => {
            if (value.getBool('isLogin') == null)
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => GirisEkrani()),
                )
              }
            else
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MapScreen()),
                )
              }
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 2,
            ),
            Text(
              "Akıllı Otopark Sistemi",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: yuksekligeGoreAyarla(context, 36)),
            ),
            Spacer(
              flex: 2,
            ),
            Image.asset('assets/images/splash.png'),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
