import 'package:receipeapp/shared/network/cache_helper.dart';

class RecipeModel{
  String?uid;
  String? name;
  String? image;
  String? category;
  String? country;
  String? description;
  List<String>? ingredients;

  RecipeModel(
      {this.name, this.image, this.category, this.country, this.description,this.ingredients});
  Map<String,dynamic>toMap(){
    return {
      'uid':CacheHelper.getData(key: 'ID'),
      'name':name,
      'image':image,
      'category':category,
      'country':country,
      'description':description,
      'ingredients':ingredients
    };
  }

  RecipeModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    image=json['image'];
    category=json['category'];
    country=json['country'];
    description=json['description'];
    ingredients=json['ingredients'].cast<String>();
  }

}