
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:receipeapp/main_layout/main_layout.dart';
import 'package:receipeapp/views/Authentication/cubit/auth_cubit.dart';
import 'package:receipeapp/views/home/home_page.dart';
import 'package:translator/translator.dart';

import '../../main_layout/cubit/app_cubit.dart';
import '../../src/core/colors.dart';
import '../../views/favorites/cubit/favorite_cubit.dart';
import 'constant.dart';

double getWidth(context)=>MediaQuery.of(context).size.width;
double getHeight(context)=>MediaQuery.of(context).size.height;

Widget defaultFormField({
  validator,
  onSubmit,
  obsText=false,
  IconData? icon,
  onTap,
  required String hint,
  required TextEditingController controller,
  TextInputType inputType=TextInputType.text,
  Color? color
})=>Container(
  decoration:const BoxDecoration(
    //borderRadius: BorderRadius.circular(radius??0),
      border: Border(
          bottom:BorderSide(color: Colors.grey)
      )
  ),
  child: Row(
    children: [
      Expanded(
        child: TextFormField(
          style: TextStyle(color:color?? Colors.white),
          obscureText: obsText,
          cursorColor:color?? Colors.white,
          keyboardType: inputType,
          onFieldSubmitted: onSubmit,
          validator: (String? value){
          if(value!.isEmpty){
            return '$hint field is empty';
          }
        },
          controller: controller,
          decoration: InputDecoration(

            hintText: hint,
            hintStyle: TextStyle(color:color?? Colors.grey,fontSize: 15),
            border:const OutlineInputBorder(
                borderSide: BorderSide.none
            ),
            focusedBorder:const OutlineInputBorder(
                borderSide: BorderSide.none
            ),
          ),
        ),
      ),
      if(hint=='Password'||hint=='Confirm password')
        InkWell(child: Icon(icon,color: Colors.grey,),onTap:onTap,)

    ],
  ),
);

defaultButton({
  double? minWidth,
  required BuildContext context,
  Color? color,
  onPressed,
  required String text,
double?  padding,
 Color? textColor,
 double? fontSize
})=>InkWell(
  onTap: onPressed,
  child: Container(
    padding: EdgeInsets.all(padding??0.0),
    width:minWidth?? getWidth(context),
    height: 50,
    decoration: BoxDecoration(
      color:color?? AppColors.secondaryAppColor(),
borderRadius: BorderRadius.circular(10)
    ),
    alignment: AlignmentDirectional.center,
    child: Text(text,style: TextStyle(color: textColor??Colors.black,fontSize:fontSize??14 ),),
  ),
);

navigateToNext(context,nextPage)=>Navigator.push(context, MaterialPageRoute(builder: (context)=>nextPage));
loginOrRegister({
 required String mainText,
 required String option,
  onTap,
})=>  Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children:  [
     Text(
      mainText,
      style:const TextStyle(color: Colors.grey),
    ),
    GestureDetector(
      onTap: onTap,
      child:  Text(
        option,
        style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: AppColors.secondaryAppColor()),
      ),
    ),
  ],
);
final translator = GoogleTranslator();
logo(context,{size,color,align,text='Tasty Plates'})=>Align(
  alignment:align?? AlignmentDirectional.center,
  child:
   Text(text,style: GoogleFonts.aladin(textStyle: TextStyle(color:AppCubit.get(context).isDark==true? Colors.white:Colors.black,fontSize:size?? 50)),

  ),
);

background()=>const BoxDecoration(
  image: DecorationImage(
    fit: BoxFit.cover,
    image: NetworkImage(
        'https://i.pinimg.com/736x/5b/32/fe/5b32feafa776777a08fdcc50ab99c886.jpg'
    ),
  ),

);

enum toastStates { error, warning, success }
toastColor(toastStates state) {
  Color color;
  switch (state) {
    case toastStates.success:
      color = Colors.black;
      break;
    case toastStates.warning:
      color = Colors.amber;
      break;
    case toastStates.error:
      color = Colors.red;
      break;
  }
  return color;
}
Future flutterToast(
    {required String msg,
      Color color = Colors.red,
      required toastStates state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: toastColor(state),
        textColor:Colors.white,
        fontSize: 16.0);

customDrawer(context,_scaffoldKey)=>Drawer(
  backgroundColor: Colors.white,
  child: Padding(
    padding: const EdgeInsets.all(5.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25,),
        InkWell(onTap: ()=>_scaffoldKey.currentState!.openEndDrawer(),child: Icon(Icons.close),),
        const SizedBox(height: 30,),
        const ExpansionTile(
          title:   Text(
            'New',
            style: TextStyle(fontSize: 17,fontWeight: FontWeight.w300),
          ),
          children: <Widget>[

          ],),

        // const SizedBox(height:5 ,),
        const ExpansionTile(
          title:   Text(
            'Apparel',
            style: TextStyle(fontSize: 17,fontWeight: FontWeight.w300),
          ),
          children: <Widget>[

          ],),
        const ExpansionTile(
          title:   Text(
            'Shoes',
            style: TextStyle(fontSize: 17,fontWeight: FontWeight.w300),
          ),
          children: <Widget>[

          ],),
        const ExpansionTile(
          title:   Text(
            'Bags',
            style: TextStyle(fontSize: 17,fontWeight: FontWeight.w300),
          ),
          children: <Widget>[

          ],),
        const ExpansionTile(
          title:   Text(
            'Beauty',
            style: TextStyle(fontSize: 17,fontWeight: FontWeight.w300),
          ),
          children: <Widget>[

          ],),
        const ExpansionTile(
          title:   Text(
            'Accessories',
            style: TextStyle(fontSize: 17,fontWeight: FontWeight.w300),
          ),
          children: <Widget>[

          ],),
        const SizedBox(height:30 ,),

        Row(
          children: [
            const SizedBox(width: 15,),
            Image.asset('assets/images/phone.jpg',width: 27,height: 27,),
            const SizedBox(width: 20,),
            const Text('+1.111.111.11',style: TextStyle(fontSize: 17),)
          ],
        ),
        const SizedBox(height: 20,),
        Row(
          children: [
            const SizedBox(width: 15,),

            Image.asset('assets/images/location.jpg',width: 27,height: 27,),
            const SizedBox(width: 20,),
            const Text('Store Locator',style: TextStyle(fontSize: 17),)
          ],
        ),
        const Spacer(),
        //socialMediaLinks(40.0),
      ],
    ),
  ),
);

Widget likeButton(context,{color,onTap,icon})=>InkWell(
  onTap:onTap,
  child:   Container(
    decoration:BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color:AppCubit.get(context).isDark==true? Colors.white.withOpacity(.7):Colors.white,
      boxShadow: [BoxShadow(
        color:color?? Colors.red.withOpacity(0.1), //color of shadow
        spreadRadius: 5, //spread radius
        blurRadius: 7, // blur radius
        offset:const Offset(0, 2), // changes position of shadow
      )],
    ) ,
    padding:const EdgeInsets.all(4.0),
    child: Icon(icon??Icons.favorite_border_rounded,color: Colors.red,size: 18,),
  ),
);

Widget navigateToPrevious(context,{color})=>InkWell(
  onTap: ()=>Navigator.pop(context),
  child:  Align(
    alignment: AlignmentDirectional.topStart,
    child: Icon(Icons.arrow_back_ios_outlined,color:color?? Colors.white,),
  ),
);

PreferredSizeWidget appBar(context,text)=>AppBar(
  backgroundColor: AppCubit.get(context).isDark?Colors.black:AppColors.primaryAppColor(),
    centerTitle: true,
    leading: IconButton(
      color:AppCubit.get(context).isDark==true? Colors.white:Colors.black,
      onPressed:() {
        Navigator.pop(context);
      },
      icon:const Icon(Icons.arrow_back_ios_outlined),
    ),
    elevation: 0.0,
    title:Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color:AppCubit.get(context).isDark==true? Colors.white:AppColors.primaryTextColor(),
      ),
    )
);

Widget shareItem(context, {onTap})=>   InkWell(
  onTap: onTap,
  child:   Container(

    decoration:BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color:AppCubit.get(context).isDark==true? Colors.white.withOpacity(.7):Colors.white,
      boxShadow: [BoxShadow(
        color: Colors.red.withOpacity(0.1), //color of shadow
        spreadRadius: 5, //spread radius
        blurRadius: 7, // blur radius
        offset: Offset(0, 2), // changes position of shadow
        //first paramerter of offset is left-right
        //second parameter is top to down
      )],
    ),
    padding: EdgeInsets.all(4.0),
    child: Icon(Icons.near_me_sharp,color: Colors.red,size: 18,),
  ),
);
Widget line()=>ConstrainedBox(
  constraints: BoxConstraints(maxWidth: 40),
  child: Container(
    height: 5,
    width: 50,
    decoration: BoxDecoration(
      color: AppColors.secondaryAppColor(),
      borderRadius: BorderRadius.circular(50),
    ),
  ),
);
Widget googleLogin(context,text)=>ElevatedButton(

style: ButtonStyle(
  shadowColor:MaterialStateProperty.all(Colors.transparent) ,
  minimumSize: MaterialStateProperty.all( Size(getWidth(context), 50)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side:const BorderSide(color: Color.fromRGBO(255,0,0, 1))
        )
    ),
  backgroundColor:MaterialStateProperty.all<Color>(Colors.transparent),
),
  onPressed: (){
  AuthCubit.get(context).googleLogin(context).then((value) => navigateToNext(context, MainLayout()));
},child: Text('Sign $text with Google',style:const TextStyle(color: Color.fromRGBO(255,0,0, 1),fontSize: 16),));


 ratingBar2({initialRating, selectedIcon, ratingMethod}) {
      return RatingBar.builder(
        initialRating: initialRating,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        unratedColor: Colors.amber.withOpacity(.4),
        itemCount: 5,
        itemSize: 30.0,
        itemPadding:const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) =>
            Icon(
              selectedIcon ?? Icons.star,
              color: Colors.amber,
            ),
        onRatingUpdate: ratingMethod,
        updateOnDrag: true,
      );
}
getCloseButton(context) {
  return Container(
    padding: const EdgeInsets.only(bottom: 1),
    alignment: FractionalOffset.topRight,
    child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.close,
          color: Colors.grey,
        )),
  );
}

alertDialogButton(context,{required Function() onPressed,required String text,required Color color,required Color backColor})=>TextButton(
    style: ButtonStyle(
      shape:
      MaterialStateProperty.all(
          RoundedRectangleBorder(
              borderRadius:
              BorderRadius
                  .circular(
                  15))),
      backgroundColor:
      MaterialStateProperty.all<
          Color>( backColor),
    ),
    onPressed: onPressed,
    child:   Text(text,
        style: TextStyle(
            color:color// AppColors.secondaryAppColor()
        )));



