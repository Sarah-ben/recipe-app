import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:receipeapp/shared/components/compoents.dart';

import '../../main_layout/cubit/app_cubit.dart';
import '../../main_layout/cubit/app_state.dart';
import '../../models/categoriesModel/category_model.dart';
import '../../src/core/colors.dart';
import 'categories_products_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(builder: (context,state){
      return
      Container(
        color: AppColors.primaryAppColor(),
        width: getWidth(context),
        height: getHeight(context),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Menu',
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryTextColor(),
                ),
              ),
              SizedBox(
                height: getHeight(context),
                child: GridView.count(crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                children: List.generate(AppCubit.get(context).categoryModel.category.length, (index) => gridItem(AppCubit.get(context).categoryModel.category[index], context))
                  ,)
              )
            ],
          ),
        )));},listener: (context,state){});
  }

  Widget gridItem(DataModel model, context) => InkWell(
        onTap: () async{
          await AppCubit.get(context).getCategories(category:model.strCategory!);

          navigateToNext(context, CategoriesProductsScreen(AppCubit.get(context).areaModel.meals,model.strCategory));
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image:  DecorationImage(
                  image: NetworkImage(
                      model.strCategoryThumb!))),
          child: Container(
            padding:const EdgeInsets.all(10),
            alignment: AlignmentDirectional.bottomStart,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(.1),
                  Colors.black.withOpacity(.5)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            //color: Colors.black26,
            child: Text(
              '${model.strCategory}',

              style:TextStyle(

                fontSize: 17,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor(),

              ),
            ),
          ),
        ),
      );
}
