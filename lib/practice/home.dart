import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

import '../Models/apimodels.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Apimodels> listApi=[];
  Future<List<Apimodels>> getPostApi ()async{
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
    var data=jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for(var i in data){
        listApi.add(Apimodels.fromJson(i));
      }
      return listApi;
    }else{
      return listApi;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getPostApi(),
          builder: (context,Snapshot){
          if(!Snapshot.hasData){
           return Text('Loading....');
          }else{
            return ListView.builder(
                itemCount: listApi.length,

                itemBuilder: (context,index){
                  return Padding(

                    padding: const EdgeInsets.all(13.0),
                    child: Card(
                      elevation: 4,
                       shape:RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(12.0)
                       ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: <TextSpan >[
                                  TextSpan(
                                    text: "Name\n",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,

                                    )
                                  ),
                                  TextSpan(
                                    text: "          ",
                                  ),
                                  TextSpan(
                                    text: listApi[index].name.toString()  ,
                                  ),
                                  TextSpan(
                                    text: "\n",
                                  ),
                                  TextSpan(
                                      text: "Email\n",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,

                                      )
                                  ),
                                  TextSpan(
                                    text: "          ",
                                  ),

                                  TextSpan(
                                    text: listApi[index].email.toString()  ,
                                  ),
                                  TextSpan(
                                    text: "\n",
                                  ),
                                  TextSpan(
                                      text: "Body\n",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,

                                      )
                                  ),
                                  TextSpan(
                                    text: "          ",
                                  ),

                                  TextSpan(
                                    text: listApi[index].body.toString() ,
                                  )
                                ]
                              )
                            ),


                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          }
          }
      ),
    );
  }
}
