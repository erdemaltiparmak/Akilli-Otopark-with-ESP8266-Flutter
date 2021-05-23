import 'package:flutter/material.dart';
import '/screens/components/widgets.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

TextEditingController _eMail = TextEditingController();

class SifreYenile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(context),
      body: SafeArea(
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
                SizedBox(
                  height: yuksekligeGoreAyarla(context, 48),
                ),
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
                  height: yuksekligeGoreAyarla(context, 4),
                ),
                Padding(
                  padding: EdgeInsets.all(genisligeGoreAyarla(context, 27)),
                  child: Button(
                    onPressed: () async {
                      if (await resetPassword(_eMail.text))
                        _showMyDialog(context,
                            "E-mail adresinize parola sıfırlama bağlantısı içeren bir e posta gönderildi.");
                    },
                    title: "Gönder",
                    buttonColor: kPrimaryColor,
                    fontColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: yuksekligeGoreAyarla(context, 48),
                ),
              ],
            ),
          ),
        ),
      )),
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
      "Şifre Yenile",
      style: TextStyle(
          color: kPrimaryColor,
          fontWeight: FontWeight.w500,
          fontSize: yuksekligeGoreAyarla(context, 27)),
    ),
  );
}

Future<bool> resetPassword(String email) async {
  try {
    return true;
  } catch (e) {}
  return false;
}

Future<void> _showMyDialog(BuildContext context, String hata) async {
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
              Image.network(
                "https://cdn.icon-icons.com/icons2/1506/PNG/512/emblemok_103757.png",
                height: yuksekligeGoreAyarla(context, 96),
              ),
              Text(
                hata,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        // contentTextStyle: TextStyle(fontFamily: 'Muli'),
        actions: <Widget>[
          Button(
            title: "Tamam",
            buttonColor: kPrimaryColor,
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
