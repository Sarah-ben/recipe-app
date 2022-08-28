import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:receipeapp/src/modules/foodDetails/widgets/food_details_app_bar.dart';
import 'package:receipeapp/src/modules/foodDetails/widgets/food_infos.dart';
import 'package:receipeapp/src/modules/foodDetails/widgets/ingredient_list.dart';
import 'package:receipeapp/src/modules/foodDetails/widgets/ingredients_heading.dart';
import 'package:receipeapp/src/modules/foodDetails/widgets/prepare_step_heading.dart';
import 'package:receipeapp/src/modules/foodDetails/widgets/prepare_step_list.dart';

import '../../widgets/custom_divider.dart';

class FoodDetailsPage extends StatelessWidget {
  const FoodDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          FoodDetailsAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  height: 260,
                  width: double.infinity,
                  child: Image.network(
                    'https://static8.depositphotos.com/1273864/887/i/950/depositphotos_8878946-stock-photo-japanese-cuisine-gourmet-soup-food.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FoodInfos(),
                      CustomDivider(),
                      IngredientsHeading(),
                    ],
                  ),
                )
              ],
            ),
          ),
          IngredientList(),
          PrepareStepHeading(),
          PrepareStepList(),
        ],
      ),
    );
  }
}
