import 'package:flutter/material.dart';
import 'package:receipeapp/src/core/colors.dart';
import 'package:receipeapp/src/modules/foodDetails/food_details_page.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 6,
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FoodDetailsPage()));
        },
        child: SizedBox(
          height: 250,
          width: 260,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Image.asset('assets/images/splash_logo.PNG',fit: BoxFit.cover,)
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 15, top: 15, right: 8, left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Papapira parba guyi',
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryTextColor(),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '4.8 (120+)',
                              style: GoogleFonts.inter(),
                            ),
                          ],
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(
                              Icons.av_timer_outlined,
                              color: AppColors.primaryWidgetColor(),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '10 mins',
                              style: GoogleFonts.inter(
                                color:
                                    AppColors.secondaryTextColor(opacity: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
