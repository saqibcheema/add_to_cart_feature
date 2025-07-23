import 'package:flutter/cupertino.dart';
import 'cartmodel.dart';
import 'dbHelper.dart';

class CartProvider with ChangeNotifier{

  var db=DbHelper.instance;

  int _counter=0;
  int get counter => _counter;
  double _totalPrice=0.0 ;
  double get totalPrice => _totalPrice;

  late Future<List<Cart>> _cart;

  Future<List<Cart>> getData() {
    _cart=db.getCart();
    return _cart;
  }

  Future<void> updateTotalFromDb() async {
    List<Cart> items = await db.getCart();
    _totalPrice = items.fold(0.0, (sum, item) => sum + (item.productPrice ?? 0));
    notifyListeners();
  }


  void incrementCounter(){
    _counter++;
    notifyListeners();
  }

  void decrementCounter(){
    _counter--;
    notifyListeners();
  }

  int getCounter(){
    return _counter;
  }

  void addTotalPrice(double productPrice){
    _totalPrice +=  productPrice;
    notifyListeners();
  }

  void removeTotalPrice(double productPrice){
    _totalPrice -=  productPrice;
    notifyListeners();
  }

  double getTotalPrice(){
    return _totalPrice;
  }
}