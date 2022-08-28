class TodayMealModel{
  String?name;
  String?id;
  String?image;
  String?category;
  TodayMealModel({this.name, this.image,this.id,this.category});
  Map<String,dynamic>toJson(){
    return {
      'id':id,
      'name':name,
      'image':image,
      'category':category,
    };
  }

  TodayMealModel.fromJson(Map<String,dynamic>map){
    id=map['id'];
    name=map['name'];
    image=map['image'];
    category=map['category'];
  }

}