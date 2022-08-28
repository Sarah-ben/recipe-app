import 'package:flutter/material.dart';
import 'package:receipeapp/src/modules/foodDetails/food_details_page.dart';
import 'package:receipeapp/src/modules/home/widgets/long_food_card.dart';

class BreakfastList extends StatelessWidget {
  const BreakfastList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 12, right: 12, top: 12),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 5),
              child: LongFoodCard(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FoodDetailsPage(),
                    ),
                  );
                },
              ),
            );
          },
          childCount: 3,
        ),
      ),
    );
  }
}
