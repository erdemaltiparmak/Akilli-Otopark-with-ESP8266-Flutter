import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

TextFormField buildKullaniciAdi(BuildContext context) {
  return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value.isEmpty) {
          return kUsernameNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Kullanıcı Adı",
        hintText: "Kullanıcı Adınız...",
        suffixIcon: Icon(Icons.alternate_email, color: kTextColor),
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
      ));
}

TextFormField buildAd(BuildContext context) {
  return TextFormField(
      keyboardType: TextInputType.name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value.isEmpty) {
          return kNamelNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Ad",
        hintText: "Adınız...",
        suffixIcon: Icon(Icons.person_outline, color: kTextColor),
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
      ));
}

TextFormField buildSoyad(BuildContext context) {
  return TextFormField(
      keyboardType: TextInputType.name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value.isEmpty) {
          return kSurnameNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Soyad",
        hintText: "Soyadınız",
        suffixIcon: Icon(Icons.person_outline, color: kTextColor),
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
      ));
}

TextFormField buildSifre(BuildContext context, TextEditingController _password,
    {@required bool dogrulama}) {
  return TextFormField(
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
        } else if (value.length < 8) {
          return kShortPassError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: dogrulama ? "Şifre Doğrula" : "Şifre",
        hintText:
            dogrulama ? "Şifrenizi tekrar giriniz" : "Şifrenizi giriniz...",
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
      ));
}

TextFormField buildEmail(BuildContext context, TextEditingController _eMail) {
  return TextFormField(
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
      ));
}
