import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:receipeapp/main_layout/cubit/app_state.dart';
import 'package:receipeapp/models/favoriteModel/favorite_model.dart';
import 'package:receipeapp/shared/components/compoents.dart';
import 'package:receipeapp/shared/network/cache_helper.dart';
import 'package:receipeapp/views/Details/details_screen.dart';
import 'package:receipeapp/views/favorites/cubit/favorite_cubit.dart';
import 'package:receipeapp/views/favorites/cubit/favorite_states.dart';
import 'package:receipeapp/views/home/home_page.dart';

import '../../main_layout/cubit/app_cubit.dart';
import '../../shared/components/constant.dart';
import '../../shared/style/theme/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  print(AppCubit.get(context).favorites.length);
    return BlocConsumer<FavoriteCubit, FavoriteStates>(
      builder: (BuildContext context, state) {
        //AppCubit.get(context).getUserData();
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: appBar(context, 'Wishlist\'s items'),
          body: Container(
            padding: const EdgeInsets.all(30),
            color: AppCubit.get(context).isDark
                ? Colors.black
                : AppColors.primaryAppColor(),
            child: FavoriteCubit.get(context).myFav.length == 0
                ? Center(
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          color: AppCubit.get(context).isDark
                              ? Colors.redAccent.withOpacity(.3)
                              : Colors.red.withOpacity(.7),
                        ),
                        child: const Text(
                          'List is Empty  :(',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      //AppCubit.get(context).getMeal(favorit: AppCubit.get(context).favorites[index]);
                      return favItems(
                          FavoriteCubit.get(context).myFav[
                              index] //AppCubit.get(context).favorites[index],
                          ,
                          context);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: FavoriteCubit.get(context)
                        .myFav
                        .length // AppCubit.get(context).favorites.length
                    ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  Widget favItems(FavoriteModel model, context) => InkWell(
        onTap: () async {
          await AppCubit.get(context).getMeal(favorit: model.id);
          navigateToNext(context,
              DetailScreen(mealPerName: AppCubit.get(context).mealPerName));
        },
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: AppCubit.get(context).isDark == true
              ? Colors.grey.withOpacity(.4)
              : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Row(
              children: [
                Container(
                  width: getWidth(context) / 3.8,
                  height: 120,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage('${model.image}'))),
                ),
                Expanded(
                  child: Container(
                    height: 120,
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${model.name}',
                          style: TextStyle(
                            //overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppCubit.get(context).isDark
                                ? Colors.white
                                : AppColors.primaryTextColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                likeButton(context, onTap: () {
                  FavoriteCubit.get(context).removeFavorite(model.id);
                 // FavoriteCubit.get(context).getFavorites();
                  //  List list=CacheHelper.getData(key: "wishlist");
                }, icon: Icons.favorite)
              ],
            ),
          ),
        ),
      );
}
