import 'package:flutter/material.dart';
import 'package:receipeapp/src/core/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodDetailsAppBar extends StatelessWidget {
  const FoodDetailsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      floating: true,
      foregroundColor: Color(0xFF222222),
      title: Text(
        'Back',
        style: GoogleFonts.inter(
          color: AppColors.secondaryTextColor(),
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: Color(0xFFEEEEEE).withOpacity(0.1),
      titleSpacing: -10,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20),
          child: Icon(
            Icons.favorite,
            color: AppColors.primaryWidgetColor(),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.file_upload_outlined,
            color: Color(0xFF222222),
          ),
        ),
      ],
    );
  }
}
