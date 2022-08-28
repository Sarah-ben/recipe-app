import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static SharedPreferences? sharedPreferences  ;

  static init()async
  {
    sharedPreferences =await SharedPreferences.getInstance();
  }

  static Future putData({
    required key,
    required val
  })async{
    return await sharedPreferences!.setBool(key,val);
  }

  static Future putList({
    required key,
    required val
  })async{
    return await sharedPreferences!.setStringList(key,val);
  }

  static  getData({
    required key
  }){
    return  sharedPreferences!.get(key);
  }
  static Future saveData({
    required key,
    required val
  })async{
    if(val is String) {return await sharedPreferences!.setString(key, val);}
    if(val is int) {return await sharedPreferences!.setInt(key, val);}
    if(val is bool) {return await sharedPreferences!.setBool(key, val);}
    return await sharedPreferences!.setDouble(key, val);
  }

}