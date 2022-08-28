import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:receipeapp/models/recipeModel/recipe_model.dart';
import 'package:receipeapp/shared/components/compoents.dart';
import 'package:receipeapp/shared/network/cache_helper.dart';

import 'add_recipe_states.dart';

class AddRecipeCubit extends Cubit<AddRecipeStates>{
  AddRecipeCubit() : super(InitialState());
  static AddRecipeCubit get(context)=>BlocProvider.of(context);
  var picker = ImagePicker();
  File?Image;

 uploadPicture()async{
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Image = File(pickedFile.path);
      emit(AddImagePickedSuccessState());
    } else {
      emit(AddImagePickedErrorState());
    }
  }

  void uploadImage({
    required String name,
    required String description,
    required String category,
    required String country,
    required List<String>ingredients

  }) {
    emit(LoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(Image!.path)
        .pathSegments
        .last}')
        .putFile(Image!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        uploadRecipeData(name: name, description: description, image: value, category: category, country: country, ingredients: ingredients);
         emit(UploadPickedImageSuccessState());
        //uploadUserData(name: name, bio: bio, profile: value);

      }).catchError((onError) {
        emit(UploadPickedImageErrorState());
        print(onError.toString());
      });
    }).catchError((onError) {
      emit(UploadPickedImageErrorState());
    });
  }
  void uploadRecipeData({
    required String name,
    required String description,
    required String image,
    required String category,
    required String country,
    required List<String>ingredients

  }) {
    {
      RecipeModel model = RecipeModel(name:name ,image:image ,category: category,country:country ,description:description ,ingredients:ingredients );
      FirebaseFirestore.instance
          .collection('Recipes')
          .doc()
          .set(model.toMap())
          .then((value) {
            getRecipes();
        flutterToast(msg: 'Your recipe added successfully :) ', state: toastStates.success);
      }).catchError((onError) {
        emit(AddRecipeErrorState());
      });
    }
  }

  List<String>ingredients=[];
  addIngredientsToList(String value){
    ingredients.add(value);
    emit(AddIngredientsToList());
  }
  removeIngredientsFromList(String value){
    ingredients.remove(value);
    emit(RemoveIngredientsFromList());
  }
  List<RecipeModel> data=[];
 RecipeModel recipe=RecipeModel();
  getRecipes()async{
    data=[];
   await FirebaseFirestore.instance.collection('Recipes').where('uid',isEqualTo: CacheHelper.getData(key: 'ID')).get().then((value){
      value.docs.forEach((element) {
        //print('data i want is ${element.data()}');
        recipe=RecipeModel.fromJson(element.data());
        data.add(recipe);
        emit(GetRecipesState());
       // print(recipe.ingredients);
      });
      print(data.length);

    });
  }
}