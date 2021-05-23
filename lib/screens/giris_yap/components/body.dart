import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:ilkproje/screens/components/widgets.dart';
import '../../../constants.dart';
import '../../../main.dart';
import '../../../size_config.dart';
import 'sifre_yenile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding:
            EdgeInsets.symmetric(horizontal: genisligeGoreAyarla(context, 24)),
        child: GirisWidget());
  }
}

class GirisWidget extends StatelessWidget {
  const GirisWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          height: yuksekligeGoreAyarla(context, 40),
        ),
        Text(
          "Akıllı Otopark Sistemi",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: yuksekligeGoreAyarla(context, 30)),
        ),
        SizedBox(
          height: yuksekligeGoreAyarla(context, 8),
        ),
        Text(
          "Hoş Geldiniz :)",
          style: TextStyle(
              color: Colors.black, fontSize: yuksekligeGoreAyarla(context, 26)),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: yuksekligeGoreAyarla(context, 36),
        ),
        GirisFormu(),
      ],
    );
  }
}

TextEditingController _eMail = TextEditingController();
TextEditingController _password = TextEditingController();

class GirisFormu extends StatefulWidget {
  static Future init() async {}

  @override
  _GirisFormuState createState() => _GirisFormuState();
}

class _GirisFormuState extends State<GirisFormu> {
  bool isLogin;
  SharedPreferences sp;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) => sp = value);
  }

  bool isChecked = false;

  @override
  void dispose() {
    super.dispose();
  }

  _GirisFormuState();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Expanded(
        child: Column(
          children: <Widget>[
            Container(
              // height: yuksekligeGoreAyarla(context, 200),
              child: Column(
                children: <Widget>[
                  //    buildEmail(context, _eMail),
                  TextFormField(
                      controller: _eMail,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        labelStyle: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
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
                    height: yuksekligeGoreAyarla(context, 15),
                  ),
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
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Şifre",
                        hintText: "Şifrenizi giriniz...",
                        suffixIcon: Icon(Icons.lock_outline, color: kTextColor),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
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
                    height: yuksekligeGoreAyarla(context, 2),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      checkColor: Colors.white,
                      activeColor: kPrimaryColor,
                      onChanged: (bool value) {
                        setState(() {
                          isChecked = value;
                        });
                      },
                    ),
                    Text("Beni Hatırla"),
                    Spacer(flex: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SifreYenile()));
                      },
                      child: Text(
                        "Şifremi Unuttum",
                        style: TextStyle(
                          fontSize: genisligeGoreAyarla(context, 14),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: yuksekligeGoreAyarla(context, 15),
                ),
                //  GirisYapButon(_formKey),
                Button(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      await Firebase.initializeApp();

                      if (await signIn(_eMail.text, _password.text, context)) {
                        if (isChecked == true) {
                          _saveSharedPreferences().then((value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapScreen()));
                          });
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapScreen()));
                        }
                      } else {}
                      setState(() {});
                    }
                  },
                  title: "Giriş Yap",
                  buttonColor: kPrimaryColor,
                  fontColor: Colors.white,
                  fontSize: yuksekligeGoreAyarla(context, 21),
                ),
                NoAccountText()
              ],
            ),
            SizedBox(
              height: yuksekligeGoreAyarla(context, 48),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> signIn(String email, String password, BuildContext context) async {
  await Firebase.initializeApp();

  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      _showMyDialog(context, "Bu maille bir kullanıcı kaydı bulunamadı.");
    } else if (e.code == 'wrong-password') {
      _showMyDialog(context, "Şifreniz yanlış");
    } else {
      _showMyDialog(context, "Kayıt Bulunamadı");
    }
  }
}

Future<String> _saveSharedPreferences() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setBool("isLogin", true);
  await sharedPreferences.setString("userName", _eMail.text);
  return "OK";
}

Future<void> _showMyDialog(BuildContext context, String hata) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          primary: true,
          child: ListBody(
            children: <Widget>[
              Text(hata),
            ],
          ),
        ),
        // contentTextStyle: TextStyle(fontFamily: 'Muli'),
        actions: <Widget>[
          Button(
            title: "Tamam",
            buttonColor: Colors.red,
            fontColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
