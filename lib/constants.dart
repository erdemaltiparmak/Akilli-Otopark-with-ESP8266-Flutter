import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xff01b7c3);
const kTextColor = Color(0xFF757575);
const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Kullanıcı adı boş geçilemez";
const String kInvalidEmailError = "Lütfen geçerli bir e-mail adresi giriniz";
const String kPassNullError = "Şifre alanı boş geçilemez";
const String kShortPassError = "Parola en az 7 karakterden oluşmalı";
const String kNamelNullError = "Ad alanı boş geçilemez";
const String kSurnameNullError = "Soyad alanı boş geçilemez";
const String kUsernameNullError = "Kullanıcı adı aannı boş geçilemez";

RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
Function mathFunc = (Match match) => '${match[1]}.';

class Screens {
  final String title;
  final Widget screen;

  Screens(this.title, this.screen);
}

class PopUpMenuItems {
  final IconData icon;
  final String text;
  final Function() func;

  PopUpMenuItems(this.icon, this.text, this.func);
}
