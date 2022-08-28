class FavoriteModel{
  String?name;
  String?id;
  String?image;
  FavoriteModel({this.name, this.image,this.id});
  Map<String,dynamic>toJson(){
    return {
      'id':id,
      'name':name,
      'image':image,
    };
  }

FavoriteModel.fromJson(Map<String,dynamic>map){
    id=map['id'];
    name=map['name'];
    image=map['image'];
}

}