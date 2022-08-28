import 'dart:core';

import 'package:receipeapp/models/mealModel/area_model.dart';

class UserModel{
  String? name;
  String? email;
  String? uid;

  UserModel(
      this.name,
      this.email,
      this.uid,
     );

  Map<String,dynamic>toMap(){
    return {
      'name':name,
      'email':email,
      'uid':uid,

    };

  }
UserModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    uid=json['uid'];

}
}