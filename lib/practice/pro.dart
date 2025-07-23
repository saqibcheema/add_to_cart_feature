import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/complexModel.dart';
 

class Pro extends StatefulWidget {
   const Pro({super.key});



  @override
  State<Pro> createState() => _ProState();
}

class _ProState extends State<Pro> {

  Future<ComplexModel> productGet () async{
    final response=await http.get(Uri.parse('https://api.myjson.online/v1/records/60129fcc-127f-4b5e-8a5c-e410e9802781'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      return ComplexModel.fromJson(data);
    }else{
      return ComplexModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ComplexModel>(
        future: productGet (),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return  Text('');
          }else{
            return Text('Loading');
          }

        }
    );
  }
}
