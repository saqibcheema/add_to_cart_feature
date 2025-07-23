import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart 'as http;

class ApiTesting extends StatefulWidget {
  const ApiTesting({super.key});

  @override
  State<ApiTesting> createState() => _ApiTestingState();
}

class _ApiTestingState extends State<ApiTesting> {
  @override
List<dynamic> data=[];
  Future<void> getuserApi() async{
    await Future.delayed(Duration(microseconds: 400));
    var response= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode==200){
      data=jsonDecode(response.body.toString());

    }
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getuserApi(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: Column(
                children: [
                  SizedBox(
                     height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Loading...',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,decoration: TextDecoration.none,),
                  ),
                ],
              ),

            );
          }else{
            return ListView.builder(
              itemCount: data.length,
                itemBuilder: (context, index){
                  return Card(
                    child: Column(
                      children: [
                        ReuseableRow(title: 'name',value:data [index]['name'].toString() ,),
                        ReuseableRow(title: 'Lngitude',value:data [index]['address'] ['geo'] ['lng'].toString() ,)
                      ],
                    ),
                  );
                }
            );
          }
        }
    );
  }
}

class ReuseableRow extends StatelessWidget {
    const ReuseableRow({super.key,required this.title, required this.value});
final String title,value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value)
        ],
      ),
    );
  }
}


