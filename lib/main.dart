import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipeapp/main_layout/cubit/app_state.dart';
import 'package:receipeapp/shared/components/constant.dart';
import 'package:receipeapp/shared/network/cache_helper.dart';
import 'package:receipeapp/shared/network/dio_helper.dart';
import 'package:receipeapp/shared/style/theme/theme.dart';
import 'package:receipeapp/src/modules/home/widgets/recomended_food_list.dart';
import 'package:receipeapp/views/add_recipe/add_recipe.dart';
import 'package:receipeapp/views/add_recipe/cubit/add_recipe_cubit.dart';
import 'package:receipeapp/views/add_recipe/my_recipes.dart';
import 'package:receipeapp/views/favorites/cubit/favorite_cubit.dart';
import 'package:receipeapp/views/home/home_page.dart';
import 'package:receipeapp/views/Authentication/cubit/auth_cubit.dart';
import 'package:receipeapp/views/Authentication/cubit/auth_states.dart';
import 'package:receipeapp/views/Authentication/login/login_screen.dart';
import 'package:receipeapp/views/Categories/categories.dart';
import 'package:receipeapp/views/Categories/categories_products_screen.dart';
import 'package:receipeapp/views/Details/details_screen.dart';
import 'package:receipeapp/views/Profile/profile_screen.dart';
import 'package:receipeapp/views/favorites/favorite_screen.dart';
import 'package:receipeapp/views/start/start_page.dart';
import 'package:receipeapp/views/todaysMeal/cubit/mealCubit.dart';
import 'package:translator/translator.dart';

import 'main_layout/cubit/app_cubit.dart';
import 'main_layout/main_layout.dart';
import 'views/Authentication/register/register_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DioHelper.init();
  await CacheHelper.init();
  var isDark=CacheHelper.getData(key: "isDark");
  var uid=CacheHelper.getData(key: "ID");
  Widget startPage;
  if(uid!=null){
    startPage=MainLayout();
  }else{
    startPage=const StartPage();
  }
  runApp( MyApp(dark: isDark,startPage: startPage,));
}

class MyApp extends StatelessWidget {
  final dark;
  final startPage;
  const MyApp({this.dark,this.startPage});

  @override
  Widget build(BuildContext context) {
    print('is it in dark mode : $dark');
    return MultiBlocProvider(providers: [
         BlocProvider(create: (BuildContext context)=>AppCubit()..changeAppMode(Dark: dark)..getAreas()..getCategories()),
         BlocProvider(create: (BuildContext context)=>AuthCubit()..getUserData()),
         BlocProvider(create: (BuildContext context)=>AddRecipeCubit()..getRecipes()),
         BlocProvider(create: (BuildContext context)=>FavoriteCubit()..getFavorites()),
         BlocProvider(create: (BuildContext context)=>TodayMealCubit()..getTodayMeals()),
    ], child: BlocConsumer<AppCubit,AppStates>(builder: (context,state){
      return  MaterialApp(
        theme: lightTheme,
        themeMode: AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: startPage,
      );
    },listener: (context,state){
    },));
  }

}
