import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'cartmodel.dart';

class DbHelper{
  DbHelper._instance();
  static final DbHelper instance=DbHelper._instance();
  static Database?  _database;

  Future<Database?> get database async{



    if (_database != null){
      return _database;
    }

    _database= await initDb();
    return _database;

  }

  Future<Database> initDb()async{
    String databasePath=await getDatabasesPath();
    String path= join(databasePath, 'cartDB');

    return await openDatabase(path, version: 1, onCreate: onCreate );
  }

  Future<void> onCreate(Database _database,int version)async{
    await _database.execute(
        '''
      CREATE TABLE cart(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      productId TEXT UNIQUE,
      productName TEXT, 
      productPrice INTEGER,
      quantity INTEGER,
      image TEXT
      )
      '''
    );
  }

  Future<Cart> insert(Cart cart)async{
    Database? db=await instance.database;
    await db!.insert('cart', cart.toMap());
    return cart;
  }

  Future<List<Cart>> getCart()async{
    Database? db=await instance.database;
    final List<Map<String,dynamic>> queryResult = await db!.query('cart');
    return queryResult.map((e)=> Cart.fromMap(e)).toList();
  }

  Future<int> deleteCart(int id)async{
    Database? db=await instance.database;
    return await db!.delete(
        'cart',
        where: 'id=?',
        whereArgs:  [id]
    );
  }

}