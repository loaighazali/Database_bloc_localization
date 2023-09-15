
import 'package:shared_preferences/shared_preferences.dart';

enum PrefKey{
  lang
}

class SharedPrefControllar {

  static final SharedPrefControllar _instance = SharedPrefControllar.internal();
  late SharedPreferences _sharedPreferances ;

  SharedPrefControllar.internal();

  factory SharedPrefControllar(){
    return _instance ;
  }

  Future<void> initPref() async{
    _sharedPreferances = await SharedPreferences.getInstance();
  }

  Future<void> setLanguage ({required String lang})async{
    await _sharedPreferances.setString(PrefKey.lang.toString(), lang);
  }

  String get language => _sharedPreferances.getString(PrefKey.lang.toString()) ?? 'en';
}