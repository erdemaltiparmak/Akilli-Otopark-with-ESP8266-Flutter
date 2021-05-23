import 'package:flutter/material.dart';
import 'package:ilkproje/screens/components/widgets.dart';
import 'package:ilkproje/screens/giris_yap/giris_ekrani.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.only(top: genisligeGoreAyarla(context, 42)),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: genisligeGoreAyarla(context, 24),
          ),
          child: Column(
            children: <Widget>[
              Text(
                "Hesabınızı Oluşturun",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: yuksekligeGoreAyarla(context, 28),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: yuksekligeGoreAyarla(context, 48),
              ),
              KayitFormu(),
            ],
          ),
        ),
      ),
    ));
  }
}

class KayitFormu extends StatefulWidget {
  @override
  _KayitFormuState createState() => _KayitFormuState();
}

class _KayitFormuState extends State<KayitFormu> {
  TextEditingController _eMail = TextEditingController();
  TextEditingController _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                  child: Column(
                children: [
                  //buildEmail(context),
                  TextFormField(
                      controller: _eMail,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,

                      // onSaved: (newValue) => email = newValue,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                        } else if (emailValidatorRegExp.hasMatch(value)) {}
                        return null;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return kEmailNullError;
                        } else if (!emailValidatorRegExp.hasMatch(value)) {
                          return kInvalidEmailError;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "E-Mail",
                        hintText: "E-mail adresiniz...",
                        suffixIcon: Icon(Icons.mail_outline, color: kTextColor),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: yuksekligeGoreAyarla(context, 40),
                            vertical: genisligeGoreAyarla(context, 14)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: kTextColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: kTextColor),
                        ),
                      )),

                  SizedBox(
                    height: yuksekligeGoreAyarla(context, 20),
                  ),
                  //buildSifre(context,dogrulama: false),
                  SizedBox(
                    height: yuksekligeGoreAyarla(context, 20),
                  ),
                  //buildSifre(context,dogrulama: true),
                  TextFormField(
                      controller: _password,
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                        } else if (value.length >= 8) {}
                        return "";
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return kPassNullError;
                        } else if (value.length < 7) {
                          return kShortPassError;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Şifre",
                        hintText: "Şifrenizi giriniz...",
                        suffixIcon: Icon(Icons.lock_outline, color: kTextColor),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: yuksekligeGoreAyarla(context, 40),
                            vertical: genisligeGoreAyarla(context, 14)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: kTextColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: kTextColor),
                        ),
                      )),

                  SizedBox(
                    height: yuksekligeGoreAyarla(context, 30),
                  ),
                ],
              )),
              Column(
                children: [
                  Button(
                    onPressed: () async {
                      // await Firebase.initializeApp();
                      // if(await register(_eMail.text, _password.text, context)) {
                      //   await FirebaseAuth.instance.signInWithEmailAndPassword(email: _eMail.text, password: _password.text);

                      //  await _showMyDialog(context, mesaj:"Kaydınız başarıyla oluşturuldu.\nGiriş Yapabilirsiniz",basariliMi: true);
                      // }
                      // else{
                      //   _showMyDialog(context,mesaj: "Bu e-maile kayıtlı bir hesap zaten var", basariliMi: false) ;

                      // }
                      await _showMyDialog(context,
                          mesaj:
                              "Kaydınız başarıyla oluşturuldu.\nGiriş Yapabilirsiniz",
                          basariliMi: true);
                    },
                    title: "Kayıt Ol",
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
    );
  }
}

Future<bool> register(
    String email, String password, BuildContext context) async {
  // try {
  //   await FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(email: email, password: password);
  //   return true;
  // } on FirebaseAuthException catch (e) {
  //    if (e.code == 'email-already-in-use') {
  //    //  _showMyDialog(context,mesaj: "Bu e-maile kayıtlı bir hesap zaten var", basariliMi: false) ;
  //    }
  //   return false;
  // } catch (e) {
  //   print(e.toString());
  //   return false;
  // }
  return true;
}

Future<void> _showMyDialog(BuildContext context,
    {String mesaj, @required bool basariliMi}) async {
  return showDialog<void>(
    context: context,
    // barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        //  title: Text('AlertDialog Title'),
        content: SingleChildScrollView(
          primary: true,
          child: ListBody(
            children: <Widget>[
              Text(mesaj),
            ],
          ),
        ),
        // contentTextStyle: TextStyle(fontFamily: 'Muli'),
        actions: <Widget>[
          Button(
            title: (basariliMi) ? "Giriş Yap" : "Tamam",
            buttonColor: (basariliMi) ? Colors.green : Colors.red,
            fontColor: Colors.white,
            onPressed: () {
              if (basariliMi) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => GirisEkrani()));
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
