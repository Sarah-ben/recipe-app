import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:receipeapp/main_layout/cubit/app_state.dart';
import 'package:receipeapp/models/mealModel/area_model.dart';
import 'package:receipeapp/shared/components/compoents.dart';
import 'package:receipeapp/src/core/colors.dart';
import 'package:receipeapp/views/Details/details_screen.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../main_layout/cubit/app_cubit.dart';
import '../../shared/components/constant.dart';
import '../../shared/network/cache_helper.dart';
import '../favorites/cubit/favorite_cubit.dart';

class CategoriesProductsScreen extends StatelessWidget {
  List<MealModel>? meals;
  String? strCategory;
  CategoriesProductsScreen(this.meals,  this.strCategory);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(builder: (BuildContext context, state) {
      return Scaffold(
          appBar: AppBar(
            title: Text(strCategory!,style: GoogleFonts.aBeeZee(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color:AppCubit.get(context).isDark?Colors.white:Colors.black,
            ),),
            elevation: 0.0,
            leading: InkWell(
                onTap: ()=>Navigator.pop(context),
                child: Icon(Icons.arrow_back_ios_outlined,color:AppCubit.get(context).isDark?Colors.white:Colors.black,)),   ),
          body:  Container(
              color: AppColors.primaryAppColor(),
              padding:const EdgeInsets.only(left: 20,right: 20,bottom: 30),
              height: getHeight(context),
              width: getWidth(context),
              child:StaggeredGridView.countBuilder(
                physics:const BouncingScrollPhysics(),
                crossAxisCount: 2,
                itemCount: meals!.length,
                itemBuilder: (context, index) => items( meals![index],context),
                staggeredTileBuilder: (index) =>const StaggeredTile.fit(1),
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 8.0,
              ))
      );
    }, listener: (BuildContext context, Object? state) {  },) ;
  }

  items(MealModel model,context) {
   return GestureDetector(
      onTap: () async{
        await AppCubit.get(context).getMeal(mealModel: model);
        navigateToNext(context, DetailScreen(mealPerName: AppCubit.get(context).mealPerName));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          //border: Border.all(color: Colors.grey.withOpacity(.5))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        '${model.strMealThumb}'
                    ),),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: likeButton(context, onTap: () {
                    FavoriteCubit.get(context)
                        .data
                        .contains(model.idMeal)
                        ? FavoriteCubit.get(context)
                        .removeFavorite(model.idMeal)
                        : FavoriteCubit.get(context).addToFavorites(
                        model.strMealThumb,
                        model.strMeal,
                        model.idMeal);
                    FavoriteCubit.get(context).getFavorites();
                  },
                      icon: FavoriteCubit.get(context)
                          .data
                          .contains(model.idMeal)
                          ? Icons.favorite
                          : Icons.favorite_outline),
                )
              ],
            ),

            Text(' ${model.strMeal}', style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w600,
              fontSize: 15,
              height: 1.5,
              color: AppCubit.get(context).isDark == true ? Colors.white : AppColors
                  .primaryTextColor(),),

            ),


          ],
        ),
      ),
    );
  }
}
