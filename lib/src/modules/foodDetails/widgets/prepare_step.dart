import 'package:flutter/material.dart';
import 'package:receipeapp/src/core/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PrepareStep extends StatelessWidget {
  final int prepareStepNumber;
  const PrepareStep({
    Key? key,
    required this.prepareStepNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: AppColors.primaryWidgetColor(),
            shape: BoxShape.circle,
          ),
          child: Text(
            prepareStepNumber.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry is standard dummy text ever since the 1500s, when',
            style: GoogleFonts.inter(fontSize: 14.5),
            overflow: TextOverflow.clip,
          ),
        )
      ],
    );
  }
}
