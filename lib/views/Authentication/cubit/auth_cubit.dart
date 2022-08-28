import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:receipeapp/main_layout/cubit/app_cubit.dart';
import 'package:receipeapp/shared/network/dio_helper.dart';
import 'package:receipeapp/views/start/start_page.dart';
import '../../../models/userModel/user_model.dart';
import '../../../shared/components/compoents.dart';
import '../../../shared/network/cache_helper.dart';
import '../../Categories/categories.dart';
import '../../Profile/profile_screen.dart';
import '../../home/home_page.dart';
import '../login/login_screen.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(InitialApp());

  static AuthCubit get(context) => BlocProvider.of(context);

  IconData suffix= Icons.visibility_outlined;
  bool isPasswordShown=true;

  void changeVisibility(){
    isPasswordShown=!isPasswordShown;
    suffix=isPasswordShown==true?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

// user login
 login(context,{required email, required password}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      flutterToast(msg: 'Logged in successfully!', state: toastStates.success);

      emit(LoginSuccessState(value.user!.uid,value.user!.email!));
    }).catchError((onError) {
      flutterToast(msg: 'Something went wrong, try again!', state: toastStates.error,);
      print(onError.toString());
        emit(LoginErrorState(onError.toString()));
    });
  }

  // user register
  void register(context,
      {required String name,
      required String email,
      required String password,

     }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('user uid is ${value.user!.uid}');
      userCreate(context,
           name: name, email: email, userId: value.user!.uid);
      emit(RegisterSuccessState(value.user!.uid,value.user!.email!));
      flutterToast(msg: 'Account created successfully!', state: toastStates.success);

    }).catchError((onError) {
      flutterToast( msg: 'Something went wrong, try again!', state: toastStates.error);
      print(onError.toString());
       emit(RegisterErrorState(onError.toString()));
    });
  }

// user add to fire store
  void userCreate(context,
      {required String name,
      required String email,
      required userId,

     }) {
    UserModel userModel = UserModel(
      name,
      email,
      userId,

    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userModel.toMap())
        .then((value) {
      emit(CreateUserSuccessState(userId));
    }).catchError((onError) {
      emit(CreateUserErrorState(onError.toString()));
    });
  }

  final googleSignIn=GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user=>_user!;
  Future googleLogin(context)async{
    final googleUser=await googleSignIn.signIn();
    if(googleUser!=null){
      _user=googleUser;

      final googleAuth=await googleUser.authentication;
      final credential=GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        print('wanted uid : ${value.user!.uid}');
        print('wanted name : ${value.user!.displayName}');
        print('wanted email : ${value.user!.email}');
        userCreate(context, name:value.user!.displayName! , userId: value.user!.uid, email: value.user!.email!);
        emit(LoginWithGoogle(value.user!.uid,value.user!.email!,));

      });
    }
  }

  Future logout()async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
   late UserModel userModel;
  getUserData()async{
   await FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'ID')).get().then((value) async {
      userModel= UserModel.fromJson(value.data()!);
      //print('email from getData${userModel.email}');
    //  print('wishlist from getData${CacheHelper.getData(key: 'wishlist')}');
    });
  }

  deleteAccount(context){
    FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'ID')).delete().then((value) {
      CacheHelper.sharedPreferences!.clear().then((value) =>                                         navigateToNext(context, StartPage())
      );
      emit(DeleteAccountState());
    });
  }
}
