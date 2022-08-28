import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipeapp/models/recipeModel/recipe_model.dart';
import 'package:receipeapp/shared/components/compoents.dart';
import 'package:receipeapp/src/core/colors.dart';
import 'package:receipeapp/views/add_recipe/add_recipe.dart';
import 'package:receipeapp/views/add_recipe/cubit/add_recipe_cubit.dart';
import 'package:receipeapp/views/add_recipe/cubit/add_recipe_states.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../main_layout/cubit/app_cubit.dart';

class MyRecipe extends StatelessWidget {
  const MyRecipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddRecipeCubit,AddRecipeStates>(builder: (BuildContext context, state) {
      AddRecipeCubit cubit=AddRecipeCubit.get(context);
      return Scaffold(
        appBar: appBar(context, 'My recipe'),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          icon:const Icon(Icons.add,color: Colors.white,),
          label:const Text("Add recipe",style: TextStyle(color: Colors.white),),
          backgroundColor: AppColors.secondaryAppColor(),
          onPressed: ()=>//cubit. getRecipes(),
          navigateToNext(context, AddRecipe()),
        ),
        body:Container(
            color:AppCubit.get(context).isDark?Colors.black :AppColors.primaryAppColor(),
            padding:const EdgeInsets.only(left: 20,right: 20,bottom: 30),
            height: getHeight(context),
            width: getWidth(context),
            child:cubit.data.isEmpty?
            Center(child: Container(
                padding:const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius:const BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30),bottomRight:  Radius.circular(30)),
                  color:AppCubit.get(context).isDark? Colors.redAccent.withOpacity(.3):Colors.red.withOpacity(.7),
                ),
                child: const Text('List is Empty  :(',style:  TextStyle(color: Colors.white,fontSize: 18),)),):
            StaggeredGridView.countBuilder(
              physics:const BouncingScrollPhysics(),
              crossAxisCount: 2,
              itemCount: cubit.data.length,
              itemBuilder: (context, index) => items(cubit.data[index] ,context),
              staggeredTileBuilder: (index) =>const StaggeredTile.fit(1),
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 8.0,
            )
        ),
      );
    }, listener: (BuildContext context, Object? state) {  },);


  }
  items(RecipeModel model,context) {
    return GestureDetector(
      onTap: () async{
       // await AppCubit.get(context).getMeal(mealModel: model);
       // navigateToNext(context, DetailScreen(mealPerName: AppCubit.get(context).mealPerName));
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
                      '${model.image}'
                       // 'https://i.pinimg.com/564x/cc/a5/e6/cca5e6645d0890b15e4fcdb44223f129.jpg'
                    ),),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(

                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                        color: AppColors.rateColor(),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    width: 50,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: AppColors.primaryTextColor(),
                          size: 15,)
                        , const Text('4.5', style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            height: 1.5
                        ))
                      ],
                    ),
                  ),
                )
              ],
            ),

            Text('${model.name}', style: TextStyle(
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
