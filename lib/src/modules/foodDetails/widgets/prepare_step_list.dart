import 'package:flutter/material.dart';
import 'package:receipeapp/src/modules/foodDetails/widgets/prepare_step.dart';

class PrepareStepList extends StatelessWidget {
  const PrepareStepList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 12, right: 12, top: 12),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              child: PrepareStep(
                prepareStepNumber: index,
              ),
            );
          },
          childCount: 6,
        ),
      ),
    );
  }
}
