import 'package:flutter/material.dart';
import 'package:ilkproje/screens/kayit_ol/kayit_ekrani.dart';

import '../../constants.dart';
import '../../size_config.dart';

class Button extends StatelessWidget {
  final Function onPressed;
  final Color buttonColor;
  final Color fontColor;
  final double fontSize;
  final String title;

  const Button(
      {Key key,
      @required this.onPressed,
      this.buttonColor,
      this.fontColor,
      this.title,
      this.fontSize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      onPressed: onPressed,
      color: buttonColor ?? Colors.lightBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 4.0,
          ),
          Text(
            title,
            style:
                TextStyle(color: fontColor ?? Colors.white, fontSize: fontSize),
          ),
        ],
      ),
    );
  }
}

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.only(top: genisligeGoreAyarla(context, 2)),
          child: Text(
            "Bir Hesabınız Yok Mu? ",
            style: TextStyle(fontSize: genisligeGoreAyarla(context, 14)),
            textAlign: TextAlign.justify,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KayitEkrani(),
              )),
          child: Text(
            "Kayıt Olun",
            style: TextStyle(
                fontSize: genisligeGoreAyarla(context, 16), color: kTextColor),
          ),
        ),
      ],
    );
  }
}
