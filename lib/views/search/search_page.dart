
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:receipeapp/main_layout/cubit/app_cubit.dart';
import 'package:receipeapp/models/mealModel/area_model.dart';
import 'package:receipeapp/shared/network/cache_helper.dart';
import 'package:receipeapp/src/modules/home/widgets/long_food_card.dart';
import 'package:receipeapp/shared/components/wave_transition_animation.dart';
import 'package:receipeapp/views/Details/details_screen.dart';
import 'package:receipeapp/views/search/widgets/search_bar.dart';

import '../../../main_layout/cubit/app_state.dart';
import '../../../shared/components/compoents.dart';
import '../../../shared/style/theme/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;

  final GlobalKey<WaveTransitionAnimationState> _myKey =
      GlobalKey<WaveTransitionAnimationState>();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  void backToHome() {
    _myKey.currentState!.controller
        .reverse()
        .whenComplete(() => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        backToHome();
        return Future.value(false);
      },
      child: WaveTransitionAnimation(
        waveStart:const FractionalOffset(1, 0),
        key: _myKey,
        duration:const Duration(milliseconds: 600),
        child: BlocConsumer<AppCubit,AppStates>(listener: (BuildContext context, state) {  },
          builder: (BuildContext context,  state) {
          return  Scaffold(
            backgroundColor: Colors.black.withOpacity(0.8),
            body: SafeArea(
              child: Container(
                padding:const EdgeInsets.only(left: 15, right: 15, top: 10),
                height: double.infinity,
                child: SingleChildScrollView(
                  physics:const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SearchBar(
                        onBackPress: backToHome,
                        onClearPress: ()=>
                          _searchController.clear()
                        ,
                        onChanged:  (String v){
                          AppCubit.get(context).searchData(v);
                        },
                      ),

                      Container(
                        padding: EdgeInsets.all(10),
                        height: getHeight(context)-100 ,
                        width: getWidth(context),
                        child: ListView.separated(
                          physics:const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context,index){
                            return  search(context,AppCubit.get(context).search[index]);
                          }, separatorBuilder: (context,index)=>const SizedBox(height: 10,), itemCount: AppCubit.get(context).search.length,),
                      ),
                      //)
                    ],
                  ),
                ),
              ),
            ),
          );
          },)

      ),
    );
  }

  Widget search(context,MealPerName model)=>InkWell(
    onTap: ()async{
      await AppCubit.get(context).getMeal(favorit: model.idMeal);
      navigateToNext(context, DetailScreen(mealPerName: model,));
    },
    child: SizedBox(
      width: getWidth(context),
      child: Text('${model.strMeal}', style: GoogleFonts.aBeeZee(
        height: 1.8,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppCubit.get(context).isDark==true? Colors.white:AppColors.primaryTextColor(),                      ),
          ),),
  );
}
