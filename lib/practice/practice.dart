import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:practice_api/Models/practice.dart';

class HomeTwo extends StatefulWidget {
    HomeTwo({super.key});

  @override
  State<HomeTwo> createState() => _HomeTwoState();
}

class _HomeTwoState extends State<HomeTwo> {
  List<Practice> getApi=[];
  Future<List<Practice>> getPhotos() async {
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data){
        getApi.add(Practice.fromJson(i));


      }return getApi;
    }else{
      return getApi;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Api Testing'),),
      body: FutureBuilder(
          future: getPhotos(),
          builder: (context,AsyncSnapshot<List<Practice>> snapshot){
            return ListView.builder(
              itemCount: getApi.length,
                itemBuilder: (context,index){
                  return ListTile(
                    leading:CircleAvatar(
                      backgroundImage:  NetworkImage(snapshot.data![index].url.toString()),
                    ),
                    title:  Text(snapshot.data![index].url.toString() ),

                    trailing: Text('Id: ${snapshot.data![index].id.toString()}'),
                  );
                }
            );
          }
      ),
    );
  }
}




