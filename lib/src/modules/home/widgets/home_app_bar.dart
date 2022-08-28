import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipeapp/main_layout/cubit/app_cubit.dart';
import 'package:receipeapp/shared/network/cache_helper.dart';
import 'package:receipeapp/src/core/colors.dart';
import 'package:receipeapp/src/modules/search/search_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:receipeapp/views/favorites/cubit/favorite_cubit.dart';
import 'package:receipeapp/views/favorites/favorite_screen.dart';
import 'package:receipeapp/views/start/start_page.dart';

import '../../../../shared/components/compoents.dart';
import '../../../../shared/components/constant.dart';
import '../../../../views/Authentication/cubit/auth_cubit.dart';

class HomeAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leadingWidth: 0,
      titleSpacing: 12,
      elevation: 0,
      leading:const SizedBox(),
      title: logo(context,size: 30.0,color: Colors.black,align: AlignmentDirectional.topStart),
      backgroundColor: Colors.transparent,
      actions: [
        InkWell(
          onTap:
                () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, _) {
                    return SearchPage();
                  },
                  opaque: false,
                ),
              );

          },
          child:const Icon(Icons.search,size: 20,),
        ),
      Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              IconButton(onPressed:
                 (){
               // await AppCubit.get(context).getUserData();
                //CacheHelper.sharedPreferences!.clear().then((value) => navigateToNext(context, StartPage())),
    navigateToNext(context, FavoriteScreen());},
               icon:const Icon(Icons.favorite_border_rounded,
                  size: 19,
                  // color: Colors.black
               )),
              if(FavoriteCubit.get(context).data.length>0)
                Container(
                padding:const EdgeInsets.only(bottom: 2,left: 2,right: 2),
                height: 15,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text('${FavoriteCubit.get(context).data.length}',style: const TextStyle(    color:Colors.white,
                ),),
              )
            ],
          ),
      const SizedBox(width: 5,),
        InkWell(
            onTap: ()=>AppCubit.get(context).changeAppMode(),
            child: Icon(Icons.wb_sunny_outlined,size: 24,)),
        const SizedBox(width: 10,),


      ],
    );
  }
}
