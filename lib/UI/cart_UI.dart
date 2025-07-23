import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Ecommerce/cartProvider.dart';
import '../Ecommerce/cartmodel.dart';
import '../Ecommerce/dbHelper.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var db=DbHelper.instance;
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Ecommerce Cart'),
        actions: [
          badges.Badge(
            showBadge: true,
            badgeAnimation: badges.BadgeAnimation.scale(),
            badgeContent: Selector<CartProvider, int>(
              selector: (context, provider) => provider.getCounter(),
              builder: (context, counter, _) {
                return Text(
                  counter.toString(),
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
            child: Icon(Icons.shopping_bag_outlined),

          ),
          SizedBox(width: 20,)
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: cart.getData(),
            builder: (context,AsyncSnapshot<List<Cart>> snapshot){
              if(snapshot.hasData){
                return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Card(
                              elevation: 6,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 170,
                                      width: 170,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            snapshot.data![index].image.toString(),
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black12,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(

                                                child: Text(
                                                  snapshot.data![index].productName.toString(),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () async {
                                                    await db.deleteCart(int.parse(snapshot.data![index].id.toString()));
                                                    cart.decrementCounter();

                                                    // Don’t manually subtract — recalculate
                                                    await cart.updateTotalFromDb();
                                                  },

                                                  icon: Icon(Icons.delete)
                                              )
                                            ],
                                          ),

                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${snapshot.data![index].productPrice} \$ ',
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: (){},
                                                      icon: Icon(Icons.remove)
                                                  ),
                                                  Text('1'),
                                                  IconButton(
                                                      onPressed: (){},
                                                      icon: Icon(Icons.add)
                                                  )
                                                ],

                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ));
              }else{
                return Text('Data Not found');
              }

            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Visibility(
              visible: cart.getTotalPrice().toStringAsFixed(2) =='0.00' ? false : true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Price'),
                  Text(' ${cart.getTotalPrice().toStringAsFixed(2)}' ),

                ],),
            ),
          )
        ],
      ),
    );
  }
}
