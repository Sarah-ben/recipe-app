import 'package:flutter/material.dart';
import 'package:receipeapp/src/core/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Ingredient extends StatelessWidget {
  const Ingredient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 9,
          width: 9,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryWidgetColor(),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          '2 tbsp Sugar',
          style: GoogleFonts.inter(
            fontSize: 15.5,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryTextColor(opacity: 0.9),
          ),
        )
      ],
    );
  }
}
