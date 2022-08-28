import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:receipeapp/views/home/home_page.dart';
import 'package:receipeapp/views/Authentication/register/register_screen.dart';

import '../../../shared/components/compoents.dart';
import '../login/login_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  TextEditingController emailController=TextEditingController();
  GlobalKey<FormState>formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 50,),
                  InkWell(
                      onTap: ()=>navigateToNext(context, LoginScreen()),
                      child:const Icon(Icons.arrow_back,color: Colors.white,)),
                  const SizedBox(height: 50,),
                  defaultFormField(hint: 'Email address', controller: emailController,inputType: TextInputType.emailAddress),
                  const SizedBox(height: 150,),
                  defaultButton(text: 'Reset password',context: context,color: Colors.white,onPressed: (){
                    if(formKey.currentState!.validate()){
                    FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).then((value) =>flutterToast(msg: 'Verify your email', state: toastStates.success));
                    }
                    navigateToNext(context, HomePage());
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  forgotPassword()=>InkWell(
    onTap: (){
    },
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
