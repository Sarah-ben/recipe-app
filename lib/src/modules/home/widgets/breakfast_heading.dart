import 'package:flutter/material.dart';
import 'package:receipeapp/src/core/colors.dart';
import 'package:receipeapp/src/widgets/line.dart';
import 'package:google_fonts/google_fonts.dart';

class BreakfastHeading extends StatelessWidget {
  const BreakfastHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Breakfast',
              style: GoogleFonts.inter(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryTextColor(),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Line()
          ],
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          onPressed: () {},
          child: Text(
            'VIEW ALL',
            style: GoogleFonts.inter(
              fontSize: 15,
              color: AppColors.primaryWidgetColor(),
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
