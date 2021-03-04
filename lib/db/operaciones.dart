
import 'package:e_commerce/db/db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class Operaciones{
 static int total = 0;
  static Future<Database> _opneDB() async{
    return openDatabase(
      join(await getDatabasesPath(), 'productos.db'),
      onCreate: (db,version){
        return db.execute("CREATE TABLE productos(producto TEXT PRIMARY KEY, subprecio INTEGER)",
        );
      },version: 3
    );

  }

  static Future<void> insert(Productos productos) async{
    Database database = await _opneDB();
    return database.insert("productos", productos.toMap());

  }
  static Future<List<Productos>> productos() async{
    Database database = await _opneDB();
    final List<Map<String, dynamic>> productosmap = await database.query("productos");
    return List.generate(productosmap.length, (i) => Productos(idproductos:productosmap[i]['producto'],subprecio: productosmap[i]['subprecio']));
  }

  static Future<void> deleteProducto(String id) async {
    // Get a reference to the database.
    Database database = await _opneDB();

    // Remove the Dog from the Database.
    await database.delete(
      'productos',
      // Use a `where` clause to delete a specific dog.
      where: "producto = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

 Future calculateTotal() async {
   Database database = await _opneDB();
   var result = await database.rawQuery("SELECT * FROM productos");
   return result.toList();
 }


}