import 'package:flutter/material.dart';
import 'package:receipeapp/views/start/widgets/bottom_container.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.network(
                'https://i.pinimg.com/736x/5b/32/fe/5b32feafa776777a08fdcc50ab99c886.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: BottomContainer(),
            ),
          ],
        ),
      ),
    );
  }
}
