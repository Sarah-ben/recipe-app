import 'package:flutter/material.dart';
import 'package:receipeapp/src/core/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodInfos extends StatelessWidget {
  const FoodInfos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Papapira parba guyi',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryTextColor(),
              ),
            ),
            Wrap(
              children: [
                Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 247, 225, 27),
                ),
                Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 247, 225, 27),
                ),
                Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 247, 225, 27),
                ),
                Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 247, 225, 27),
                ),
                Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 247, 225, 27),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '120 calories',
              style: GoogleFonts.inter(
                color: AppColors.secondaryTextColor(opacity: 0.7),
              ),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.av_timer_outlined,
                  color: Color(0xFF2EBF8D),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '10 mins',
                  style: GoogleFonts.inter(
                    color: AppColors.secondaryTextColor(opacity: 0.7),
                  ),
                ),
              ],
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.room_service_outlined,
                  color: AppColors.primaryWidgetColor(),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '1 Serving',
                  style: GoogleFonts.inter(
                    color: AppColors.secondaryTextColor(opacity: 0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
