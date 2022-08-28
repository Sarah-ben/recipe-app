import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipeapp/main_layout/cubit/app_cubit.dart';
import 'package:receipeapp/main_layout/cubit/app_state.dart';
import 'package:receipeapp/shared/components/compoents.dart';
import 'package:receipeapp/views/Details/details_screen.dart';
import 'package:receipeapp/views/favorites/cubit/favorite_cubit.dart';

import '../../../../models/mealModel/area_model.dart';
import '../../../core/colors.dart';

class FoodList extends StatefulWidget {
  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController controller = TabController(
      length: 27,
      vsync: this,
    );
    //  AppCubit.get(context).getAreas();
    //AppCubit.get(context).getMealPerArea();

    return SliverToBoxAdapter(
        child: BlocConsumer<AppCubit, AppStates>(
            builder: (context, state) {
              return AppCubit.get(context).countryModel.country.length > 0 &&
                      AppCubit.get(context).model.meals.length >0
                  ? Container(
                      padding: const EdgeInsets.all(8.0),
                      // color: Colors.red.withOpacity(.07),
                      width: getWidth(context),
                      height: getHeight(context) + 66,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            width: getWidth(context),
                            child: TabBar(
                           //   labelColor: Colors.orange,
                                //indicatorColor: AppCubit.get(context).isDark?Colors.black:AppColors.primaryAppColor(),
                             //   unselectedLabelColor: Colors.red,
                                indicator:const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.transparent,
                                    ),
                                  ),
                                ),
                                onTap: (int i) async {
                                  print(i);
                                  AppCubit.get(context).getAreas(i: i);
                                 // controller.animateTo(100, duration:const Duration(milliseconds: 500), curve: Curves.easeIn);
                                },
                                isScrollable: true,
                                controller: controller,
                                tabs: List.generate(
                                    27,
                                    (index) => Text(
                                          '${AppCubit.get(context).countryModel.country[index]}',
                                          style: TextStyle(
                                              color: AppCubit.get(context)
                                                          .isDark ==
                                                      true
                                                  ? Colors.white
                                                  : Colors.black),
                                        ))),
                          ),
                          SizedBox(
                            height: getHeight(context),
                            width: double.maxFinite,
                            child: TabBarView(

                              controller: controller,
                              children: List.generate(
                                27,
                                (index) => SizedBox.expand(
                                  child: GridView.count(
                                    shrinkWrap: false,
                                    crossAxisCount: 2,
                                    childAspectRatio: .873,
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 4,
                                    children: List.generate(
                                        AppCubit.get(context)
                                            .model
                                            .meals
                                            .length,
                                        (index) => items(
                                            AppCubit.get(context)
                                                .model
                                                .meals[index],
                                            context)),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ))
                  : SizedBox(
                      height: getHeight(context),
                      width: getWidth(context),
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.orange,),
                      ));
            },
            listener: (context, state) {}));
  }
  Widget items(MealModel model, context) {
    return InkWell(
      onTap: () async {
        await AppCubit.get(context).getMeal(mealModel: model);
        AppCubit.get(context).getCategories();
        print(
            'this is wht i need : ${AppCubit.get(context).mealPerName.idMeal}');
        navigateToNext(context, DetailScreen(mealPerName: AppCubit.get(context).mealPerName));
      },
      child: Card(
        color: AppCubit.get(context).isDark == true
            ? Colors.grey.withOpacity(.4)
            : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: getWidth(context) / 2.8,
                    height: getWidth(context) / 2.8,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(80)),
                        image: DecorationImage(
                            image: NetworkImage('${model.strMealThumb}'))),
                  ),
                  likeButton(context,onTap: ()  {
                 //   FavoriteCubit.get(context).removeFavorite(model.idMeal);
                    FavoriteCubit.get(context).data.contains(model.idMeal)?FavoriteCubit.get(context).removeFavorite(model.idMeal): FavoriteCubit.get(context).addToFavorites(model.strMealThumb,model.strMeal,model.idMeal);
                   // FavoriteCubit.get(context).getFavorites();
                    //MealModel meal=await MealModel(idMeal:model.idMeal ,strMealThumb: model.strMealThumb,strMeal:model.strMeal );
                          //list.contains(meal)?AppCubit.get(context).removefav(model):AppCubit.get(context).addfav(model);
                    //CacheHelper.getData(key: "wishlist").contains(model.idMeal)?AppCubit.get(context).removeFromFavorites(model.idMeal):AppCubit.get(context).addToFavorites(model.idMeal);
                  },icon: FavoriteCubit.get(context).data.contains(model.idMeal)?Icons.favorite:Icons.favorite_outline)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: /*Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [*/
                        Text(
                      '${model.strMeal}',
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: AppCubit.get(context).isDark == true
                            ? Colors.white
                            : AppColors.primaryTextColor(),
                      ),
                    ),
                    /*Text('Vegeterian',style: TextStyle(
                            height: 1.4,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white.withOpacity(.6),
                            fontSize: 12
                          ),),*/
                    //  ],
                    // ),
                  ),
                  shareItem(context)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
