class CountryModel{
  CountryModel();
  List country=[];
  CountryModel.fromJson(Map<String,dynamic>json){
    json['meals'].forEach((element){
     // print(element['strArea']);
      print(AreasModel.fromJson(element).strArea);
      country.add(AreasModel.fromJson(element).strArea);
    });
  }
}

class AreasModel{
  String? strArea;
  AreasModel.fromJson(Map<String,dynamic>json){
    strArea=json['strArea'];
  }
}