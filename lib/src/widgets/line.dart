import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:receipeapp/src/core/colors.dart';

class Line extends StatelessWidget {
  const Line({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 40),
      child: Container(
        height: 5,
        width: 50,
        decoration: BoxDecoration(
          color: AppColors.primaryWidgetColor(),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
