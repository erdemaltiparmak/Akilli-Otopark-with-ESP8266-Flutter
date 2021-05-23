import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getSharedPreferences() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences;
}

Future<bool> isUserLogin() async {
  var sp = await getSharedPreferences();
  return sp.getBool("isLogin");
}

Future<void> clearSharedPreferences() async {
  print("çıkış tapıldu");
  var sp = await getSharedPreferences();
  await sp.clear();
}

Future<String> dynCurrentUser;

getUserName() async {
  String u =
      await getSharedPreferences().then((value) => value.getString('userName'));
  return u;
}
