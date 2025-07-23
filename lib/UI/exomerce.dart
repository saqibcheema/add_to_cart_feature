import 'package:flutter/material.dart';
import 'package:practice_api/Ecommerce/cartProvider.dart';
import 'package:practice_api/Ecommerce/cartmodel.dart';
import 'package:practice_api/Ecommerce/dbHelper.dart';
import 'package:provider/provider.dart';
import '../Models/cs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:badges/badges.dart'as badges;

import 'cart_UI.dart';

class EcommerceApi extends StatefulWidget {
  const EcommerceApi({super.key});

  @override
  State<EcommerceApi> createState() => _EcommerceApiState();
}

class _EcommerceApiState extends State<EcommerceApi> {

  var db=DbHelper.instance ;

  String headerImage =
      "https://images.unsplash.com/photo-1529655683826-aba9b3e77383?auto=format&fit=crop&w=1000&q=80";

  Future<List<Ecomercejson>> getEcommerce() async {
    List<Ecomercejson> getApi = [];
    var response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        getApi.add(Ecomercejson.fromJson(i));
      }
      return getApi;
    } else {
      return getApi;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ecommerce Api'),
        backgroundColor: Colors.teal,
        actions: [
          badges.Badge(
            badgeContent: Consumer<CartProvider>(
              builder: (ctx,_,_){
                return Text(ctx.watch<CartProvider>().getCounter().toString());
              },
            ),
            child: InkWell(
              onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
              },
                child: Icon(Icons.shopping_cart)
            ),

          ),SizedBox(width: 20,)
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<Ecomercejson>>(
          future: getEcommerce(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error loading data"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No data found"));
            }

            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                
                SliverPadding(
                  padding: EdgeInsets.all(10),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Image.network(
                                    snapshot.data![index].image.toString(),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Divider(color: Colors.grey, thickness: 1),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: ListTile(
                                      title: Text(
                                        snapshot.data![index].title ?? '',
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(
                                                        context,
                                                      ).size.width >
                                                      600
                                                  ? 11
                                                  : 14,
                                        ),
                                        maxLines: 2,
                                      ),
                                      trailing: Text(
                                        '   Price\n ${snapshot.data![index].price.toString()} \$',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom:40,
                              left:40,
                              child: ElevatedButton(
                                  onPressed: () {
                                    db.insert(
                                      Cart(
                                          productId: snapshot.data![index].id.toString(),
                                          productName: snapshot.data![index].title.toString(),
                                          productPrice: snapshot.data![index].price?.toInt(),
                                          image: snapshot.data![index].image.toString(),
                                      )
                                    );
                                    context.read<CartProvider>().incrementCounter();
                                    context.read<CartProvider>().addTotalPrice(double.parse(snapshot.data![index].price.toString()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                    foregroundColor: Colors.white,
                                  ),
                                  child:   Text('Add to cart',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 14),
                                  )
                              )
                          )
                        ],
                      );
                    }, childCount: snapshot.data!.length),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.6,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
