import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:receipeapp/views/Authentication/cubit/auth_cubit.dart';
import 'package:receipeapp/views/Authentication/cubit/auth_states.dart';
import 'package:receipeapp/views/Authentication/login/login_screen.dart';
import 'package:receipeapp/views/Profile/profile_screen.dart';

import '../../../main_layout/cubit/app_cubit.dart';
import '../../../main_layout/main_layout.dart';
import '../../../shared/components/compoents.dart';
import '../../../shared/network/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController emailController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  GlobalKey<FormState>formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(builder: (context,state){
      return  Scaffold(
        body: Container(
          width: getWidth(context),
          height: getHeight(context),
          decoration:background(),
          child: Container(
            padding:const EdgeInsets.symmetric(horizontal: 40),
            color: Colors.black.withOpacity(.8),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30,),
                    InkWell(
                        onTap: ()=>navigateToNext(context, LoginScreen()),
                        child:const Icon(Icons.arrow_back,color: Colors.white,)),
                    const SizedBox(height: 30,),
                    logo(context),
                    const SizedBox(height: 10,),
                    defaultFormField(hint: 'Email address', controller: emailController,inputType: TextInputType.emailAddress),
                    const SizedBox(height: 20,),
                    defaultFormField(hint: 'Username', controller: nameController),
                    const SizedBox(height: 20,),
                    defaultFormField(hint: 'Password', controller: passwordController,obsText: AuthCubit.get(context).isPasswordShown,
                        icon: AuthCubit.get(context).suffix,
                        onTap: (){
                          AuthCubit.get(context).changeVisibility();
                        }),

                    const SizedBox(height: 50,),
                    defaultButton(text: 'Sign up',context: context,onPressed: (){
                      if(formKey.currentState!.validate()){
                        AuthCubit.get(context).register(context, name: nameController.text, email: emailController.text, password: passwordController.text);
                      }
                    },textColor: Colors.white,fontSize: 16),
                    const SizedBox(height: 15,),
                    const  Align(
                      alignment: AlignmentDirectional.center,
                        child: Text('OR',style: TextStyle(color: Colors.white))),
                    const SizedBox(height: 15,),
                    googleLogin(context,'up'),
                    const SizedBox(height: 30,),
                    loginOrRegister(mainText: 'Already have have an account?', option: ' Sign in',onTap: ()=>navigateToNext(context, LoginScreen()),),

                  ],
                ),
              ),
            ),
          ),
        ),

      );
    }, listener: (context,state){

      if (state is RegisterSuccessState){
        CacheHelper.saveData(key: 'ID', val:state.uid).then((value) =>CacheHelper.saveData(key: 'email', val:state.email) ).then((value)async {
          print('id from listener is  : ${CacheHelper.getData(key: 'ID')}');
          await AppCubit.get(context).getUserData();
          //await FavoriteCubit.get(context).getFavorites();
          navigateToNext(context, MainLayout());
        });
      } else if (state is LoginWithGoogle){
        CacheHelper.saveData(key: 'ID', val:state.uid).then((value) =>CacheHelper.saveData(key: 'email', val:state.email) ).then((value)async {
          print('id from listener is  : ${CacheHelper.getData(key: 'ID')}');
          await AppCubit.get(context).getUserData();
          //await FavoriteCubit.get(context).getFavorites();
          navigateToNext(context, MainLayout());
        });
      }
    });

  }
}
