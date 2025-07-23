import 'package:flutter/material.dart';
import 'package:practice_api/Ecommerce/cartProvider.dart';
import 'package:practice_api/practice/pro.dart';
import 'package:provider/provider.dart';
import '../practice/PostApi.dart';
import '../practice/complexApi.dart';
import 'exomerce.dart';
import '../practice/imageuploadonserver.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:    EcommerceApi(),

    );
  }
}


