import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:receipeapp/main_layout/cubit/app_state.dart';
import 'package:receipeapp/shared/components/compoents.dart';
import 'package:receipeapp/shared/network/cache_helper.dart';
import 'package:receipeapp/shared/style/theme/colors.dart';
import 'package:receipeapp/views/Authentication/cubit/auth_cubit.dart';
import 'package:receipeapp/views/Authentication/cubit/auth_states.dart';
import 'package:receipeapp/views/Authentication/login/login_screen.dart';
import 'package:receipeapp/views/add_recipe/add_recipe.dart';
import 'package:receipeapp/views/add_recipe/cubit/add_recipe_cubit.dart';
import 'package:receipeapp/views/add_recipe/my_recipes.dart';
import 'package:receipeapp/views/favorites/cubit/favorite_cubit.dart';
import 'package:receipeapp/views/favorites/favorite_screen.dart';
import 'package:receipeapp/views/start/start_page.dart';
import 'package:receipeapp/views/todaysMeal/todays_meal.dart';

import '../../main_layout/cubit/app_cubit.dart';
import '../../shared/components/constant.dart';
import '../todaysMeal/cubit/mealCubit.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    AppCubit.get(context).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        // AppCubit.get(context).getUserData();
        // AppCubit.get(context).addToFavorites();
        return Scaffold(
            body: Container(
                width: getWidth(context),
                height: getHeight(context),
                padding: const EdgeInsets.all(30),
                color: AppColors.primaryAppColor(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      profileHead(
                          '${AppCubit.get(context).userModel.name}', context),
                      defaultButton(
                          context: context,
                          text: 'Edit Profile',
                          minWidth: 100,
                          color: AppColors.secondaryAppColor(),
                          padding: 10.0,
                          onPressed: () {
                          },
                          textColor: Colors.white,
                          fontSize: 15),
                      const SizedBox(
                        height: 40,
                      ),
                      separator(context, 'Content'),
                      const SizedBox(
                        height: 7,
                      ),
                      contentItems('  Favorite', context,
                          icon: Icons.favorite_outline, onTap: () async {
                        //await FavoriteCubit.get(context).getFavorites();
                        navigateToNext(context, const FavoriteScreen());
                      }),
                      const SizedBox(
                        height: 7,
                      ),
                      contentItems('  My Recipe', context,
                          icon: Icons.food_bank_outlined, onTap: () async {
                        // await AddRecipeCubit.get(context).getRecipes();
                        navigateToNext(context, const MyRecipe());
                      }),
                      const SizedBox(
                        height: 7,
                      ),
                      contentItems('  Today\'s Meal', context,
                          icon: Icons.receipt, onTap: () async {
                        await TodayMealCubit.get(context).getTodayMeals();
                        navigateToNext(context, const TodayMealScreen());
                      }),
                      const SizedBox(
                        height: 15,
                      ),
                      separator(context, 'Settings'),
                      const SizedBox(
                        height: 14,
                      ),
                      contentItems(
                        'Logout',
                        context,
                        onTap: () {
                          showDialog(
                              barrierColor: AppCubit.get(context).isDark
                                  ? Colors.grey.withOpacity(.4)
                                  : Colors.grey.withOpacity(.1),
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: AppCubit.get(context).isDark
                                      ? Colors.black87
                                      : Colors.white,
                                  content: Text(
                                    'Are you sure?',
                                    style: TextStyle(
                                        color: AppCubit.get(context).isDark
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  actions: [
                                    alertDialogButton(context, onPressed: () =>Navigator.pop(context), text: "Cancel", color: Colors.white, backColor:AppCubit.get(context).isDark?  Colors.grey.withOpacity(.2).withOpacity(.3):Colors.grey),
                                    alertDialogButton(context,
                                        onPressed: () async {
                                      CacheHelper.sharedPreferences!
                                          .clear()
                                          .then((value) {
                                        print(CacheHelper.getData(key: 'ID'));
                                        navigateToNext(context, StartPage());
                                      });
                                    },
                                        text: "Logout",
                                        color: Colors.white,
                                        backColor:AppCubit.get(context).isDark?
                                        Color.fromRGBO(255, 59, 0, 1)
                                            .withOpacity(.4):Color.fromRGBO(255, 59, 0, 1)),
                                  ],
                                );
                              });
                        },
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      contentItems(
                        'Delete account',
                        context,
                        onTap: () {
                          showDialog(
                              barrierColor: AppCubit.get(context).isDark
                                  ? Colors.grey.withOpacity(.4)
                                  : Colors.grey.withOpacity(.1),
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: AppCubit.get(context).isDark
                                      ? Colors.black87
                                      : Colors.white,
                                  content: Text(
                                    'Are you sure?',
                                    style: TextStyle(
                                        color: AppCubit.get(context).isDark
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  actions: [
                                    alertDialogButton(context, onPressed: () =>Navigator.pop(context), text: "Cancel", color: Colors.white, backColor:AppCubit.get(context).isDark?  Colors.grey.withOpacity(.2).withOpacity(.3):Colors.grey),
                                    alertDialogButton(context,
                                        onPressed: ()  {
                                      AuthCubit.get(context).deleteAccount(context);
                                    },
                                        text: "Delete",
                                        color: Colors.white,
                                        backColor:AppCubit.get(context).isDark?
                                             Color.fromRGBO(255, 59, 0, 1)
                                                .withOpacity(.4):Color.fromRGBO(255, 59, 0, 1)),
                                  ],
                                );
                              });
                        },
                      ),
                    ],
                  ),
                )));
      },
    ));
  }

  Widget profileHead(String name, context) => SizedBox(
        width: double.infinity,
        height: 100,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.aBeeZee(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppCubit.get(context).isDark == true
                        ? Colors.white
                        : AppColors.primaryTextColor(),
                  ),
                ),
                Text(
                  CacheHelper.getData(key: 'email')??"",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 13,
                    height: 1.9,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(),
            VerticalDivider(
              color: Colors.grey.withOpacity(.5),
              indent: 20,
              endIndent: 20,
              thickness: 1,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '${AddRecipeCubit.get(context).data.length}\n Recipe',
              textAlign: TextAlign.center,
              style: GoogleFonts.aBeeZee(
                  fontSize: 13,
                  height: 1.7,
                  fontWeight: FontWeight.w600,
                  color:AppCubit.get(context).isDark?Colors.white: AppColors.primaryTextColor()
                  //AppCubit.get(context).isDark==true? Colors.white:AppColors.primaryTextColor(),                      ),
                  ),
            )
          ],
        ),
      );

  Widget separator(context, text) => Container(
        padding: const EdgeInsets.only(left: 10),
        alignment: AlignmentDirectional.centerStart,
        width: getWidth(context),
        height: 40,
        color: Colors.grey.withOpacity(.2),
        child: Text(
          text,
          style: GoogleFonts.aBeeZee(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
      );

  Widget contentItems(text, context, {icon, onTap}) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              if (icon != null)
                Icon(
                  icon,
                  color: AppCubit.get(context).isDark == true
                      ? Colors.white
                      : AppColors.primaryTextColor(),
                ),
              Text(
                text,
                style: GoogleFonts.aBeeZee(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppCubit.get(context).isDark == true
                      ? Colors.white
                      : AppColors.primaryTextColor(),
                ),
              ),
              const Spacer(),
              text == 'Logout'
                  ? Icon(
                      Icons.logout,
                      color: AppCubit.get(context).isDark == true
                          ? Colors.white
                          : AppColors.primaryTextColor(),
                    )
                  : text == 'Delete account'
                      ? const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )
                      : InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppCubit.get(context).isDark == true
                                ? Colors.white
                                : AppColors.primaryTextColor(),
                          ),
                        )
            ],
          ),
        ),
      );
}
