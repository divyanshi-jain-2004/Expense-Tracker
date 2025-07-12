import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/transaction_model.dart';

class DBHelper {
  static Future<Database> _getDB() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'expenses.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE transactions(id INTEGER PRIMARY KEY AUTOINCREMENT, category TEXT, amount REAL, notes TEXT, date TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<int> insertTransaction(TransactionModel txn) async {
    final db = await _getDB();
    return db.insert('transactions', txn.toMap());
  }

  static Future<List<TransactionModel>> getAllTransactions() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> data = await db.query('transactions');
    return data.map((item) => TransactionModel.fromMap(item)).toList();
  }

  static Future<void> deleteTransaction(int id) async {
    final db = await _getDB();
    await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }
}
