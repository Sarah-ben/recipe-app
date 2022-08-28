import 'package:flutter/material.dart';

import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipeapp/main_layout/cubit/app_cubit.dart';
import 'package:receipeapp/main_layout/cubit/app_state.dart';
import 'package:receipeapp/src/core/colors.dart';
import 'package:receipeapp/views/home/home_page.dart';
import 'package:receipeapp/views/Categories/categories.dart';
import 'package:receipeapp/views/Profile/profile_screen.dart';

import '../shared/components/constant.dart';
import '../views/Authentication/cubit/auth_cubit.dart';


class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  
  
  @override
  Widget build(BuildContext context){
    return  BlocConsumer<AppCubit,AppStates>(builder: (context,state){
      AppCubit.get(context).getUserData();
     var cubit=AppCubit.get(context);
      //cubit.getAreas();
      return Scaffold(
        body: cubit.tabScreens[cubit.selectedIndex],
        bottomNavigationBar: FlashyTabBar(
          backgroundColor: Colors.transparent,
          animationCurve: Curves.linear,
          selectedIndex: cubit.selectedIndex,
          showElevation: false, // use this to remove appBar's elevation
          onItemSelected: (index) => cubit.changeBottomNAvBar(index),
          items: [
            FlashyTabBarItem(
              inactiveColor: Colors.grey,
              activeColor: AppColors.secondaryAppColor(),
              icon: const Icon(Icons.home_outlined),
              title: const Text(''),
            ),
            FlashyTabBarItem(
              inactiveColor: Colors.grey,
              activeColor: AppColors.secondaryAppColor(),
              icon: const Icon(Icons.category_outlined),
              title: const Text(''),
            ),
            FlashyTabBarItem(
              inactiveColor: Colors.grey,
              activeColor: AppColors.secondaryAppColor(),
              icon:const Icon(Icons.person_outline),
              title:const Text(''),
            ),
          ],
        ),
      );
    }, listener:  (context,state){});
      
  }
}