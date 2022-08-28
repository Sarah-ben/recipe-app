import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipeapp/shared/network/cache_helper.dart';

import '../../../models/todayMealModel/todaysMealModel.dart';
import 'mealStates.dart';


class TodayMealCubit extends Cubit<TodayMealStates>{
  TodayMealCubit() : super(InitialState());

  static TodayMealCubit get(context) => BlocProvider.of(context);

  List<String> data=[];


  addToTodayMeal(image,name,id,category){

    TodayMealModel model=TodayMealModel(image: image,   name:name,id: id ,category: category);
    FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'ID')).collection('todayMeal').doc(id).set(model.toJson()).then((value)async {
      await getTodayMeals();
      //await getFavorites();
      emit(AddTodayMeal());
    });
  }
  removeFavorite(id){
    FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'ID')).collection('todayMeal').doc(id).delete().then((value) async{
      // await getFavorites();
   await getTodayMeals();
      emit(RemoveTodayMeal());
    });
  }

  List<TodayMealModel> myMeals=[];
  TodayMealModel TodayModel=TodayMealModel();
  getTodayMeals()async{
    myMeals=[];
    data=[];
    await FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'ID')).collection('todayMeal').get().then((value) {
      for (var element in value.docs) {
        TodayModel=TodayMealModel.fromJson(element.data());
        myMeals.add(TodayModel);
        data.add(TodayModel.id!);
        //CacheHelper.putList(key: 'fav', val: data);
      }
      print('length i want is : ${data.length}');
    });
  }
}