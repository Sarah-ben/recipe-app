import 'package:flutter/material.dart';
import 'package:receipeapp/src/core/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class LongFoodCard extends StatelessWidget {
  final void Function() onPressed;
  const LongFoodCard({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 90,
                    width: 90,
                    child: Image.asset('assets/images/splash_logo.PNG',fit: BoxFit.cover,)
                  ),
                 const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Papapira parba guyi',
                        style: GoogleFonts.inter(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondaryTextColor(),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 22,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                '4.8 (120+)',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                Icons.av_timer_outlined,
                                color: Color(0xFF444444),
                                size: 17,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                '10 mins',
                                style: GoogleFonts.inter(
                                  color: AppColors.secondaryTextColor(
                                    opacity: 0.8,
                                  ),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryWidgetColor(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
