import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appbar_animated/appbar_animated.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:receipeapp/main_layout/cubit/app_state.dart';
import 'package:receipeapp/models/mealModel/area_model.dart';
import 'package:receipeapp/shared/components/compoents.dart';
import 'package:receipeapp/src/core/colors.dart';
import 'package:receipeapp/views/favorites/cubit/favorite_cubit.dart';
import 'package:receipeapp/views/home/home_page.dart';
import 'package:receipeapp/views/todaysMeal/cubit/mealCubit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../main_layout/cubit/app_cubit.dart';
import '../../shared/components/constant.dart';
import 'package:share/share.dart';

class DetailScreen extends StatelessWidget {
  MealPerName? mealPerName;
  DetailScreen({this.mealPerName});

  //DetailScreen(MealModel model);

  @override
  Widget build(BuildContext context) {
    // AppCubit.get(context).getMeal(mealModel: model);
    List ingredients = [];
    double _initialRating = 0.0;

    IconData? _selectedIcon;

    return BlocConsumer<AppCubit, AppStates>(
      builder: (BuildContext context, state) {
        ingredients = [
          mealPerName?.strIngredient1,
          mealPerName?.strIngredient2,
          mealPerName?.strIngredient3,
          mealPerName?.strIngredient4,
          mealPerName?.strIngredient5,
          mealPerName?.strIngredient6,
          mealPerName?.strIngredient7,
          mealPerName?.strIngredient8,
          mealPerName?.strIngredient9,
          mealPerName?.strIngredient10,
          mealPerName?.strIngredient11,
          mealPerName?.strIngredient12,
          mealPerName?.strIngredient13,
          mealPerName?.strIngredient14
        ];
        var mes1 = mealPerName?.strMeasure1;
        var mes2 = mealPerName?.strMeasure2;
        var mes3 = mealPerName?.strMeasure3;
        var mes4 = mealPerName?.strMeasure4;
        var mes5 = mealPerName?.strMeasure5;
        var mes6 = mealPerName?.strMeasure6;
        var mes7 = mealPerName?.strMeasure7;
        var mes8 = mealPerName?.strMeasure8;
        var mes9 = mealPerName?.strMeasure9;
        var mes10 = mealPerName?.strMeasure10;
        var mes11 = mealPerName?.strMeasure11;
        var mes12 = mealPerName?.strMeasure12;
        var mes13 = mealPerName?.strMeasure13;
        var mes14 = mealPerName?.strMeasure14;
        var ing1 = '${mealPerName?.strMeasure1} ${mealPerName?.strIngredient1}';
        var ing2 = '${mealPerName?.strMeasure2} ${mealPerName?.strIngredient2}';
        var ing3 = '${mealPerName?.strMeasure3} ${mealPerName?.strIngredient3}';
        var ing4 = '${mealPerName?.strMeasure4} ${mealPerName?.strIngredient4}';
        var ing5 = '${mealPerName?.strMeasure5} ${mealPerName?.strIngredient5}';
        var ing6 = '${mealPerName?.strMeasure6} ${mealPerName?.strIngredient6}';
        var ing7 = '${mealPerName?.strMeasure7} ${mealPerName?.strIngredient7}';
        var ing8 = '${mealPerName?.strMeasure8} ${mealPerName?.strIngredient8}';
        var ing9 = '${mealPerName?.strMeasure9} ${mealPerName?.strIngredient9}';
        var ing10 =
            '${mealPerName?.strMeasure10} ${mealPerName?.strIngredient10} ';
        var ing11 =
            '${mealPerName?.strMeasure11} ${mealPerName?.strIngredient11}';
        var ing12 =
            '${mealPerName?.strMeasure12} ${mealPerName?.strIngredient12} ';
        var ing13 =
            '${mealPerName?.strMeasure13} ${mealPerName?.strIngredient13} ';
        var ing14 =
            '${mealPerName?.strMeasure14} ${mealPerName?.strIngredient14} ';
        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      '${mealPerName?.strMealThumb}',
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 40.0, bottom: 40, top: 30, left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      navigateToPrevious(context),
                      Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: likeButton(context, onTap: () {
                            FavoriteCubit.get(context)
                                    .data
                                    .contains(mealPerName?.idMeal)
                                ? FavoriteCubit.get(context)
                                    .removeFavorite(mealPerName?.idMeal)
                                : FavoriteCubit.get(context).addToFavorites(
                                    mealPerName?.strMealThumb,
                                    mealPerName?.strMeal,
                                    mealPerName?.idMeal);
                            FavoriteCubit.get(context).getFavorites();
                          },
                              icon: FavoriteCubit.get(context)
                                      .data
                                      .contains(mealPerName?.idMeal)
                                  ? Icons.favorite
                                  : Icons.favorite_outline)),
                    ],
                  ),
                ),
              ),
              Container(
                width: getWidth(context),
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.36,
                ),
                height: getHeight(context),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                  color: AppCubit.get(context).isDark == true
                      ? Colors.black
                      : Colors.white,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30.0, left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            /* ratingBar2(initialRating:_initialRating ,ratingMethod: (rating)=>AppCubit.get(context).changeRatingState(rating)
                              ,selectedIcon:_selectedIcon ),
                          */
                            Container(
                              padding: const EdgeInsets.all(5),
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                  color: AppColors.rateColor(),
                                  borderRadius: BorderRadius.circular(15)),
                              //width: 50,

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: AppColors.primaryTextColor(),
                                    size: 15,
                                  ),
                                  Text(' ${AppCubit.get(context).totalRates} ',
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          height: 1.5))
                                ],
                              ),
                            ),
                           const SizedBox(width: 20,),
                            //  IconButton(onPressed: ()=>AppCubit.get(context).addRating(mealPerName?.idMeal,AppCubit.get(context).rating), icon: Icon(Icons.add,color: Colors.white,),)
                            InkWell(
                                onTap: () {
                                  showDialog(
                                      barrierColor: AppCubit.get(context).isDark
                                          ? Colors.grey.withOpacity(.4)
                                          : Colors.grey.withOpacity(.1),
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor:
                                              AppCubit.get(context).isDark
                                                  ? Colors.black87
                                                  : Colors.white,
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                           //   getCloseButton(context),
                                              ratingBar2(
                                                  initialRating: _initialRating,
                                                  ratingMethod: (rating) =>
                                                      AppCubit.get(context)
                                                          .changeRatingState(
                                                              rating),
                                                  selectedIcon: _selectedIcon)
                                            ],
                                          ),
                                          actions: [
                                            alertDialogButton(context, onPressed: () =>Navigator.pop(context), text: "Cancel", color: Colors.white, backColor:AppCubit.get(context).isDark?  Colors.grey.withOpacity(.2).withOpacity(.3):Colors.grey),
                                            alertDialogButton(context, onPressed:  () async {
                                              AppCubit.get(context)
                                                  .addRating(
                                                  mealPerName?.idMeal,
                                                  AppCubit.get(context)
                                                      .rating);
                                              Navigator.pop(context);
                                            }, text: "Rate", color:AppCubit.get(context).isDark? AppColors.rateColor():Colors.white, backColor:AppCubit.get(context).isDark?  Color.fromRGBO(245, 230, 83, 1).withOpacity(.2).withOpacity(.3):Color.fromRGBO(245, 230, 83, 1)),
                                          ],
                                        );
                                      });
                                },
                                child: Icon(
                                      Icons.add,
                                      color:AppCubit.get(context).isDark? Colors.white:Colors.black,
                                    )),
                            const Spacer(),
                            Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: shareItem(context,
                                    onTap: () =>
                                        _shareData(mealPerName?.strYoutube)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${mealPerName?.strMeal}',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppCubit.get(context).isDark == true
                                ? Colors.white
                                : AppColors.primaryTextColor(),
                          ),
                        ),
                        Text(
                          '${mealPerName?.strCategory} | ${mealPerName?.strArea}',
                          style: GoogleFonts.aBeeZee(
                            height: 1.8,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            TodayMealCubit.get(context)
                                    .data
                                    .contains(mealPerName?.idMeal)
                                ? InkWell(
                                    onTap: () {
                                      flutterToast(
                                          msg: 'Already in your meals!',
                                          state: toastStates.warning);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey,
                                      ),
                                      child: Text(
                                        'Add to Today\'s Meal',
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () async {
                                      await TodayMealCubit.get(context)
                                          .addToTodayMeal(
                                              mealPerName?.strMealThumb,
                                              mealPerName?.strMeal,
                                              mealPerName?.idMeal,
                                              mealPerName?.strCategory);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.secondaryAppColor(),
                                      ),
                                      child: Text(
                                        'Add to Today\'s Meal',
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                            Text(
                              '  or  ',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppCubit.get(context).isDark == true
                                    ? Colors.white
                                    : AppColors.primaryTextColor(),
                              ),
                            ),
                            InkWell(
                              onTap: () =>
                                  _launchURL('${mealPerName?.strYoutube}'),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.red)),
                                child: Text(
                                  'Watch a video',
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Instructions',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppCubit.get(context).isDark == true
                                ? Colors.white
                                : AppColors.primaryTextColor(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${mealPerName?.strInstructions}',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 14,
                            height: 1.7,
                            color: AppCubit.get(context).isDark == true
                                ? Colors.white
                                : AppColors.primaryTextColor(),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Ingredients',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppCubit.get(context).isDark == true
                                ? Colors.white
                                : AppColors.primaryTextColor(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${mes1 != null ? ing1 : ''} ${mes2 != null ? ing2 : ''} ${mes3 != null ? ing3 : ''} ${mes4 != null ? ing4 : ''} ${mes5 != null ? ing5 : ''} ${mes6 != null ? ing6 : ''} ${mes7 != null ? ing7 : ''} ${mes8 != null ? ing8 : ''} ${mes9 != null ? ing9 : ''} ${mes10 != null ? ing10 : ''} ${mes11 != null ? ing11 : ''} ${mes12 != null ? ing12 : ''} ${mes13 != null ? ing13 : ''} ${mes14 != null ? ing14 : ''}',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 14,
                            height: 1.7,
                            color: AppCubit.get(context).isDark == true
                                ? Colors.white
                                : AppColors.primaryTextColor(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        if (AppCubit.get(context).mealPerName.strTags != null)
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.grey
                                        : Colors.black12),
                                color: Colors.grey.withOpacity(.05),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              '#${mealPerName?.strTags}',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppCubit.get(context).isDark
                                    ? Colors.purpleAccent
                                    : AppColors.secondaryTextColor(),
                              ),
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _shareData(url) {
    Share.share('check out this meal ${url}');
  }
}
