import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:receipeapp/main_layout/main_layout.dart';
import 'package:receipeapp/views/Authentication/register/register_screen.dart';
import 'package:receipeapp/views/favorites/cubit/favorite_cubit.dart';

import '../../../main_layout/cubit/app_cubit.dart';
import '../../../shared/components/compoents.dart';
import '../../../shared/network/cache_helper.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_states.dart';
import '../forgot_password/forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  GlobalKey<FormState>formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(builder: (context,state){
      return
      Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          width: getWidth(context),
          height: getHeight(context),
          decoration:background(),
          child: Container(
            padding:const EdgeInsets.symmetric(horizontal: 40),
            color: Colors.black.withOpacity(.8),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50,),
                  logo(context),
                  const SizedBox(height: 50,),
                  defaultFormField(hint: 'Email address', controller: emailController,inputType: TextInputType.emailAddress),
                  const SizedBox(height: 20,),
                  defaultFormField(hint: 'Password', controller: passwordController,obsText: AuthCubit.get(context).isPasswordShown,
                      icon: AuthCubit.get(context).suffix,
                      onTap: (){
                        AuthCubit.get(context).changeVisibility();
                      },
                  onSubmit: (String v){
                    if(formKey.currentState!.validate()){
                      AuthCubit.get(context).login(context, email: emailController.text, password: passwordController.text);
                    }else{
                      CircularProgressIndicator();
                    }
                  }),const SizedBox(height: 70,),
                  defaultButton(text: 'Sign in',context: context,onPressed: (){
                    if(formKey.currentState!.validate()){
                      AuthCubit.get(context).login(context, email: emailController.text, password: passwordController.text);
                    }
                  },textColor: Colors.white,fontSize: 16),
                  const SizedBox(height: 15,),

                  const  Align(
                      alignment: AlignmentDirectional.center,
                      child: Text('OR',style: TextStyle(color: Colors.white))),
                  const SizedBox(height: 15,),
                  googleLogin(context,'in'),
                  // FlatButton(height: 50,minWidth: getWidth(context),color: Colors.white,onPressed: (){}, child: Text('login')),
                  const SizedBox(height: 20,),
                  forgotPassword(context),
                  const SizedBox(height: 20,),
                  loginOrRegister(mainText:  'Don\'t have an account?', option: ' Create an account',onTap: ()=>navigateToNext(context, RegisterScreen()),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
      },listener:(context,state){
      if (state is LoginSuccessState){
        CacheHelper.saveData(key: 'ID', val:state.uid).then((value) =>CacheHelper.saveData(key: 'email', val:state.email) ).then((value)async {
          print('id from listener is  : ${CacheHelper.getData(key: 'ID')}');
          await AppCubit.get(context).getUserData();
          //await FavoriteCubit.get(context).getFavorites();
          navigateToNext(context, MainLayout());
        });
      }else if (state is LoginWithGoogle){
        CacheHelper.saveData(key: 'ID', val:state.uid).then((value) =>CacheHelper.saveData(key: 'email', val:state.email) ).then((value)async {
          print('id from listener is  : ${CacheHelper.getData(key: 'ID')}');
          await AppCubit.get(context).getUserData();
          //await FavoriteCubit.get(context).getFavorites();
          navigateToNext(context, MainLayout());
        });
      }
    } ,);
  }
  forgotPassword(context)=>InkWell(
    onTap: ()=>navigateToNext(context, ForgotPasswordScreen()),
    child: const Align(
        alignment: AlignmentDirectional.center,
        child: Text(
          'Forgot Password?',
          style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              decoration: TextDecoration.underline),
        )),
  );
}
