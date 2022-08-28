import 'package:flutter/material.dart';
import 'package:receipeapp/src/modules/foodDetails/widgets/ingredient.dart';

class IngredientList extends StatelessWidget {
  const IngredientList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 12, right: 12, top: 12),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 1,
          crossAxisCount: 2,
          childAspectRatio: 6,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Ingredient();
          },
          childCount: 6,
        ),
      ),
    );
  }
}
