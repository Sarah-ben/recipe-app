import 'package:flutter/material.dart';
import 'package:receipeapp/src/core/colors.dart';
import 'package:receipeapp/src/widgets/line.dart';
import 'package:google_fonts/google_fonts.dart';

class Heading extends StatelessWidget {
  const Heading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 12, right: 12),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [

            Container(
              //color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today\'s Gift',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryTextColor(),
                        ),
                      ),
                      InkWell(
                        onTap: ()=>null,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            'Hide',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color:Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin:const EdgeInsets.only(top: 10),
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image:const DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'https://i.pinimg.com/564x/cc/a5/e6/cca5e6645d0890b15e4fcdb44223f129.jpg'
                        )
                      ),

                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Container(
                      padding: EdgeInsets.all(25),
                      color: Colors.black54,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:const [
                           Text('Salade',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w400),),
                           //Text('Salade',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
           const SizedBox(height: 20,),
            Text(
              'Menu',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryTextColor(),
              ),
            ),
            const SizedBox(height: 20,),

            /*
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discover the meal\nof the Day!',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryTextColor(),
                      ),
                    ),
                    Column(
                      children: [
                        Text('New'),
                        SizedBox(height: 20,),
                        Text('Hide')
                      ],
                    )
                  ],
                ),
               const SizedBox(
                  height: 5,
                ),
                const Line()
              ],
            )*/
          ],
        ),
      ),
    );
  }
}
