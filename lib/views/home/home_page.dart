import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipeapp/main_layout/cubit/app_cubit.dart';
import 'package:receipeapp/src/core/colors.dart';
import 'package:receipeapp/src/modules/home/widgets/breakfast_heading.dart';
import 'package:receipeapp/src/modules/home/widgets/breakfast_list.dart';
import 'package:receipeapp/src/modules/home/widgets/food_card.dart';
import 'package:receipeapp/src/modules/home/widgets/heading.dart';
import 'package:receipeapp/src/modules/home/widgets/home_app_bar.dart';
import 'package:receipeapp/src/modules/home/widgets/long_food_card.dart';
import 'package:receipeapp/src/modules/home/widgets/recomended_food_list.dart';
import 'package:receipeapp/src/modules/search/search_page.dart';
import 'package:receipeapp/src/widgets/custom_divider.dart';
import 'package:receipeapp/src/widgets/line.dart';
import 'package:receipeapp/src/widgets/wave_transition_animation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main_layout/cubit/app_state.dart';
import '../../shared/components/compoents.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WaveTransitionAnimation(
      waveStart:const FractionalOffset(0.0, 1.0),
      duration:const Duration(milliseconds: 1100),
      child: BlocConsumer<AppCubit,AppStates>(builder: (BuildContext context, state) {
        //AppCubit.get(context).getAreas();
        return  Container(
          color: Colors.red.withOpacity(.07),
          child: CustomScrollView(
            slivers: [
              // customDrawer(context,_scaffoldKey),
              HomeAppBar(),
              //const Heading(),
              FoodList(),
              /*SliverPadding(
                padding: EdgeInsets.only(left: 12, right: 12),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      CustomDivider(),
                      BreakfastHeading(),
                    ],
                  ),
                ),
              ),
              BreakfastList()*/
            ],
          ),
        );
      }, listener: (BuildContext context, Object? state) {  },),

    );
  }
}
