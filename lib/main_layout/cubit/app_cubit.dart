import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipeapp/models/countryModel/country_model.dart';
import 'package:receipeapp/shared/network/dio_helper.dart';
import '../../models/categoriesModel/category_model.dart';
import '../../models/mealModel/area_model.dart';
import '../../models/userModel/user_model.dart';
import '../../shared/network/cache_helper.dart';
import '../../views/Categories/categories.dart';
import '../../views/Profile/profile_screen.dart';
import '../../views/home/home_page.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialApp());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({bool? Dark}) {
    if (Dark != null) {
      isDark = Dark;
      emit(ChangeAppTheme());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', val: isDark).then((value) {
        emit(ChangeAppTheme());
      });
    }
  }

  ThemeMode appMode = ThemeMode.dark;
  int selectedIndex = 0;

  List<Widget> tabScreens = [
    const HomePage(),
    const CategoriesScreen(),
    ProfileScreen()
  ];

  void changeBottomNAvBar(int i) {
    selectedIndex = i;
    emit(ChangeBottomNAvBarState());
  }

  CountryModel countryModel = CountryModel();
  List<dynamic> c = [];

  Future getAreas({i = 0}) async {
    emit(GetDataLoading());
    await DioHelper.getData(
            url: 'https://www.themealdb.com/api/json/v1/1/list.php?a=list')
        .then((value) async {
      print(value.data);
      countryModel = CountryModel.fromJson(value.data);
      print(countryModel.country);
      c = countryModel.country;
      getMealPerArea(i: c[i]);
      emit(GetDataSuccess(countryModel));
    }).catchError((onError) {
      print('error in area $onError');
    });
  }

  AreaModel model = AreaModel();

  void getMealPerArea({i = 0}) {
    //   String x=countryModel.country[0];
    //getAreas();
    //print('area in meals is : $area');
    DioHelper.getData(
            url: 'https://www.themealdb.com/api/json/v1/1/filter.php?a=${i}')
        .then((value) {
      // print(value.data['meals']);
      model = AreaModel.fromJson(value.data);
      //  meal.add(AreaModel.fromJson(value.data));
      emit(GetMealPerArea());
      print('meals canadian lenght is : ${model.meals.length}');
    }).catchError((onError) {
      print('error in canadia n food$onError');
    });
  }

  late Meal meal;
  MealPerName mealPerName = MealPerName();
  String? totalRates;

  getMeal({MealModel? mealModel, favorit}) async {
    dynamic id = mealModel?.idMeal ?? favorit;
    await DioHelper.getData(
            url: 'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id')
        .then((value) async{
      print(value.data['meals'][0]);
      meal = Meal.fromJson(value.data);
      mealPerName = MealPerName.fromJson(value.data['meals'][0]);
      print(mealPerName.idMeal);
     await FirebaseFirestore.instance
          .collection('rate')
          .doc(mealPerName.idMeal!)
          .get()
          .then((value) {
        //print('rates here are ${value.data()?['stars'].length}');
        print('total rating : ${value.data()?['totalRates']}');
        totalRates=value.data()?['totalRates']??'0.0';
        if (value.data()?['stars'] == null) {
          FirebaseFirestore.instance
              .collection('rate')
              .doc(mealPerName.idMeal!)
              .set({
            'stars': ['0'],
            'totalRates':0,
          });
          }
      });
      print(mealPerName.strMeal);
      print(meal.meal.length);
      emit(GetMealSuccess());
    }).catchError((onError) {
      print('this is the error : $onError');
    });
  }

  CategoryModel categoryModel = CategoryModel();
  List mealPerCategory = [];
  AreaModel areaModel = AreaModel();

  getCategories({String? category}) async {
    await DioHelper.getData(
            url: 'https://www.themealdb.com/api/json/v1/1/categories.php')
        .then((value) async {
      categoryModel = CategoryModel.fromJson(value.data);
      await DioHelper.getData(
              url:
                  'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category')
          .then((value) {
        areaModel = AreaModel.fromJson(value.data);
        //print('meals of $category here : ${value.data['meals']}');
        print('meals per $category here : ${areaModel.meals.length}');
        emit(GetMealSuccess());
      }).catchError((onError) {
        print('this is the error : $onError');
      });
      emit(GetCategoriesSuccess());
    }).catchError((onError) {
      print('this is the error : $onError');
    });
  }

  //List<String>myfav = [];
  //List<String>fav = [];

  late UserModel userModel;
  // List<String> favorites = [];
  // late Meal m;
  // MealPerName n=MealPerName();

  getUserData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'ID'))
        .get()
        .then((value) async {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserData());
    });
  }

  late Meal lookMeal;
  MealPerName lookMealPerName = MealPerName();
  List<MealPerName> search = [];
  List<String> historic = [];
  int i = 0;
  searchData(letter) {
    search = [];
    emit(SearchLoadingState());
    DioHelper.getData(
            url: 'https://www.themealdb.com/api/json/v1/1/search.php?f=$letter')
        .then((value) {
      lookMeal = Meal.fromJson(value.data);
      i = lookMeal.meal.length;
      for (int x = 0; x < i; x++) {
        lookMealPerName = MealPerName.fromJson(value.data['meals'][x]);
        search.add(lookMealPerName);
      }
      print('lenght of search list ${search.length}');
      emit(SearchSuccessState());
    }).catchError((onError) {
      emit(SearchErrorState());
    });
  }

  double rating = 0;
  changeRatingState(rating) {
    this.rating = rating;
    emit(RatingState());
  }

  List rates = [];
  addRating(id, rating) async {

    await FirebaseFirestore.instance
        .collection('rate')
        .doc(id)
        .get()
        .then((value) async {
      print(value.data()?['stars']);
      CacheHelper.putList(
          key: 'stars', val: value.data()!['stars'].cast<String>());
      print('bla bla bla ${CacheHelper.getData(key: 'stars')}');
      await CacheHelper.getData(key: 'stars');
      rates=CacheHelper.getData(key: 'stars');
      rates.add(rating.toString());
      print(rates.length);
      double s = 0;
      for (int i = 0; i < rates.length; i++) {
        print(double.parse(rates[i]));
        s = double.parse(rates[i]) + s;

      }
      print('s value is ${s/rates.length}');
      FirebaseFirestore.instance.collection('rate').doc(id).update({
        'stars':rates,
        'totalRates':(s/(rates.length-1)).toStringAsFixed(1)
      }).then((value) {
        FirebaseFirestore.instance.collection('rate').doc(id).get().then((value) {
          totalRates=value.data()?['totalRates'];
          print(totalRates);
          print(value.data()?['stars']);
        });
      });
    });
  }

}
