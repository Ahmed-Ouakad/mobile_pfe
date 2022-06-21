import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:single_page_app/logic/index_cubit.dart';
import 'package:single_page_app/presentation/pages/home.dart';
import 'package:single_page_app/presentation/pages/login_page.dart';
import 'package:single_page_app/presentation/pages/user_list.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: HexColor('#003A70'),
    ),
    routes: {
      '/':(context)=> LoginPage(),
      '/home': (context) =>
          BlocProvider(
            create: (context) => IndexCubit(),
            child: Home(),
          ),
      '/user_list':(context)=> UserListPage(),
    },
  ));
}