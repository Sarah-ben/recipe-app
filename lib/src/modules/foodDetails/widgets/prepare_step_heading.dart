import 'package:flutter/material.dart';
import 'package:receipeapp/src/core/colors.dart';
import 'package:receipeapp/src/widgets/custom_divider.dart';
import 'package:receipeapp/src/widgets/line.dart';
import 'package:google_fonts/google_fonts.dart';

class PrepareStepHeading extends StatelessWidget {
  const PrepareStepHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 12, right: 12),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDivider(),
                Text(
                  'Prepare your dish',
                  style: GoogleFonts.inter(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryTextColor(),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Line(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
