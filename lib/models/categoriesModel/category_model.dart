class CategoryModel{
  CategoryModel();
List<DataModel> category=[];
CategoryModel.fromJson(Map<String,dynamic>json){
  json['categories'].forEach((element) {
    category.add(DataModel.fromJson(element));
  });
}
}

class DataModel{
  String?idCategory;
  String?strCategory;
  String?strCategoryThumb;
  String?strCategoryDescription;
  DataModel.fromJson(Map<String,dynamic>json){
    idCategory=json['idCategory'];
    strCategory=json['strCategory'];
    strCategoryThumb=json['strCategoryThumb'];
    strCategoryDescription=json['strCategoryDescription'];
  }
}