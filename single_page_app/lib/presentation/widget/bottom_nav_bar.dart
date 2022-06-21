import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:single_page_app/logic/index_cubit.dart';


class BottomNavBarV2 extends StatefulWidget {
  @override
  _BottomNavBarV2State createState() => _BottomNavBarV2State();
}

class _BottomNavBarV2State extends State<BottomNavBarV2> {
  int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var my_blue = HexColor('#003A70');
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(55),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 80,
              child: Stack(

                clipBehavior: Clip.none,
                children: [
                  CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomPainter(),
                  ),
                  Center(
                    heightFactor: 0.6,
                    child: FloatingActionButton(backgroundColor: Colors.white, child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(image: AssetImage('assets/Damond_jaune.png'),),
                    ), elevation: 0.1, onPressed: () {
                      BlocProvider.of<IndexCubit>(context).setIndex(8);
                    }),
                  ),
                  Container(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Image(
                            image: AssetImage('assets/home.png'),
                            color: currentIndex == 0 ? Colors.orange : my_blue,
                          ),
                          onPressed: () {

                              BlocProvider.of<IndexCubit>(context).setIndex(0);
                              setBottomBarIndex(0);

                          },
                          splashColor: Colors.white,
                        ),
                        IconButton(
                            icon: Image(
                              image:AssetImage('assets/calendar.png'),
                              color: currentIndex == 1 ? Colors.orange : my_blue,
                            ),
                            onPressed: () {

                                BlocProvider.of<IndexCubit>(context).setIndex(1);
                                setBottomBarIndex(1);



                            }),
                        Container(
                          width: size.width * 0.20,
                        ),
                        IconButton(
                            icon: Image(
                              image: AssetImage('assets/doctor.png'),
                              color: currentIndex == 2 ? Colors.orange : my_blue,
                            ),
                            onPressed: () {

                                BlocProvider.of<IndexCubit>(context).setIndex(2);
                                setBottomBarIndex(2);

                            }),
                        IconButton(
                            icon: Image(
                              image: AssetImage('assets/menu.png'),
                              color:currentIndex == 3 ? Colors.orange : my_blue,
                            ),
                            onPressed: () {

                                BlocProvider.of<IndexCubit>(context).setIndex(3);
                                setBottomBarIndex(3);

                            }),

                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20), radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}