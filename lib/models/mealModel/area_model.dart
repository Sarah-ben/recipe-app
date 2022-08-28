class AreaModel{
  AreaModel();
 List<MealModel> meals=[];

 AreaModel.fromJson(Map<String,dynamic>json){
   json['meals'].forEach((element){
     meals.add(MealModel.fromJson(element));
   });
 }
}
class MealModel{
  String?strMeal;
  String?strMealThumb;
  String?idMeal;
  MealModel.fromJson(Map<String,dynamic>json){

    strMeal=json['strMeal'];
    strMealThumb=json['strMealThumb'];
    idMeal=json['idMeal'];
  }

  MealModel({this.idMeal, this.strMeal, this.strMealThumb});
 Map<String,dynamic>toJson(){
   return {
     'strMeal':strMeal,
     'strMealThumb':strMealThumb,
     'idMeal':idMeal,
   };

 }



}

class Meal{
  List<MealPerName>meal=[];
  Meal.fromJson(Map<String,dynamic>json){
 json['meals'].forEach((element){
  meal.add(MealPerName.fromJson(element));
});
  }
}

class MealPerName{
  MealPerName();
  String?idMeal;
  String?strMeal;
  String?strCategory;
  String?strArea;
  String?strInstructions;
  String?strMealThumb;
  String?strTags;
  String?strYoutube;
  String?strIngredient1;
  String?strIngredient2;
  String?strIngredient3;
  String?strIngredient4;
  String?strIngredient5;
  String?strIngredient6;
  String? strIngredient7;
  String? strIngredient8;
  String? strIngredient9;
  String? strIngredient10;
  String? strIngredient11;
  String? strIngredient12;
  String? strIngredient13;
  String? strIngredient14;
   String? strMeasure1  ;
   String? strMeasure2   ;
   String? strMeasure3  ;
   String? strMeasure4   ;
   String? strMeasure5   ;
   String? strMeasure6 ;
   String? strMeasure7   ;
   String? strMeasure8 ;
   String? strMeasure9  ;
   String? strMeasure10   ;
   String? strMeasure11   ;
   String? strMeasure12   ;
   String? strMeasure13   ;
   String? strMeasure14   ;
   String? strMeasure15   ;

  MealPerName.fromJson(Map<String,dynamic>json){
    idMeal=json['idMeal'];
    strMeal=json['strMeal'];
    strCategory=json['strCategory'];
    strArea=json['strArea'];
    strInstructions=json['strInstructions'];
    strMealThumb=json['strMealThumb'];
    strTags=json['strTags'];
    strYoutube=json['strYoutube'];
    strIngredient1=json['strIngredient1'];
    strIngredient2=json['strIngredient2'];
    strIngredient3=json['strIngredient3'];
    strIngredient4=json['strIngredient4'];
    strIngredient5=json['strIngredient5'];
    strIngredient6=json['strIngredient6'];
    strIngredient7=json['strIngredient7'];
    strIngredient8=json['strIngredient8'];
    strIngredient9=json['strIngredient9'];
    strIngredient10=json['strIngredient10'];
    strIngredient11=json['strIngredient11'];
    strIngredient12=json['strIngredient12'];
    strIngredient13=json['strIngredient13'];
    strIngredient14=json['strIngredient14'];
    strMeasure1=json['strMeasure1'];
    strMeasure2=json['strMeasure2'];
    strMeasure3=json['strMeasure3'];
    strMeasure4=json['strMeasure4'];
    strMeasure5=json['strMeasure5'];
    strMeasure6=json['strMeasure6'];
    strMeasure7=json['strMeasure7'];
    strMeasure8=json['strMeasure8'];
    strMeasure9=json['strMeasure9'];


  }
}
