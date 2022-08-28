import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipeapp/models/favoriteModel/favorite_model.dart';
import 'package:receipeapp/shared/network/cache_helper.dart';

import 'favorite_states.dart';

class FavoriteCubit extends Cubit<FavoriteStates>{
  FavoriteCubit() : super(InitialState());

  static FavoriteCubit get(context) => BlocProvider.of(context);

List<String> data=[];


  addToFavorites(image,name,id){
    FavoriteModel model=FavoriteModel(image: image,   name:name,id: id );
    FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'ID')).collection('favorites').doc(id).set(model.toJson()).then((value)async {
    print('added');
   await getFavorites();
      emit(AddFavorite());
    });
  }
  removeFavorite(id){
    FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'ID')).collection('favorites').doc(id).delete().then((value) async{
      await getFavorites();

      emit(RemoveFavorite());
    });
  }

  List<FavoriteModel> myFav=[];
FavoriteModel favoriteModel=FavoriteModel();
  getFavorites()async{
    myFav=[];
    data=[];
   await FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'ID')).collection('favorites').get().then((value) {
      for (var element in value.docs) {
        favoriteModel=FavoriteModel.fromJson(element.data());
        myFav.add(favoriteModel);
         data.add(favoriteModel.id!);
         //CacheHelper.putList(key: 'fav', val: data);
      }
      print('length i want is : ${data.length}');
    });
  }
}