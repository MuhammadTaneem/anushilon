// import 'package:cash_flow/providers/package_provider.dart';
// import 'package:cash_flow/widgets/investment_list.dart';
import 'dart:io';
import 'dart:async';
import 'package:mobile_app/schema/mcq_schema.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'anushilon.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE mcq(
        id INTEGER PRIMARY KEY,
        point INTEGER,
        multiChose INTEGER,
        isFavorite INTEGER,
        showAns INTEGER,
        question TEXT,
        imageUrl TEXT,
        explanation TEXT,
        explanationImgUrl TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE option(
        id INTEGER PRIMARY KEY,
        mcqId INTEGER,
        correct INTEGER,
        text TEXT,
        imageUrl TEXT
      )
    ''');

      // CREATE TABLE package(
      //     id INTEGER PRIMARY KEY,
      //     name TEXT NOT NULL,
      //     amount TEXT NOT NULL,
      //     discount TEXT NOT NULL,
      //     category TEXT NOT NULL,
      //     description TEXT DEFAULT '',
      //     startDate TEXT NOT NULL,
      //     endDate TEXT NOT NULL,
      //     exam TEXT NOT NULL,
      //     discountDate TEXT NOT NULL
      //     )
      // ''');
    // await db.execute('''
    //   CREATE TABLE expense(
    //       id INTEGER PRIMARY KEY,
    //       expenditure TEXT NOT NULL,
    //       description TEXT DEFAULT '',
    //       amount INTEGER NOT NULL,
    //       dateTime TEXT NOT NULL
    //       )
    //   ''');

  }

  // Future<List<IncomeType>> getIncome() async {
  //   Database db = await instance.database;
  //   var incomes = await db.query('incomes');
  //   List<IncomeType> incomeList =
  //   incomes.isNotEmpty ? incomes.map((c) => IncomeType.fromMap(c)).toList() : [];
  //   return incomeList;
  // }
  //
  Future<int> addMcq(McqType mcq) async {
    Database db = await instance.database;
    int mcqId = await db.insert('mcq', mcq.toMap());
    for (var option in mcq.options) {
      await db.insert('option', option.toMap(mcqId));
    }
    return mcqId;
  }
  Future<McqType?> getMcq(int mcqId) async {
    Database db = await database;
    List<Map<String, dynamic>> mcqMaps = await db.query(
      'mcq',
      where: 'id = ?',
      whereArgs: [mcqId],
    );

    if (mcqMaps.isEmpty) {
      return null;
    }
    McqType mcq = McqType.fromMap(mcqMaps.first);
    List<Map<String, dynamic>> optionMaps = await db.query(
      'option',
      where: 'mcqId = ?',
      whereArgs: [mcqId],
    );
    List<OptionType> options = optionMaps.map((map) => OptionType.fromMap(map)).toList();
    mcq.options = options;
    return mcq;
  }

  Future<List<McqType>> getAllMcq() async {
    Database db = await database;
    List<Map<String, dynamic>> mcqMaps = await db.query('mcq');
    List<McqType> mcqs = [];
    for (var mcqMap in mcqMaps) {
      McqType mcq = McqType.fromMap(mcqMap);
      List<Map<String, dynamic>> optionMaps = await db.query(
        'option',
        where: 'mcqId = ?',
        whereArgs: [mcq.id],
      );
      List<OptionType> options =
      optionMaps.map((map) => OptionType.fromMap(map)).toList();
      mcq.options = options;
      mcqs.add(mcq);
    }

    return mcqs;
  }

  Future<int> deleteMcq(int mcqId) async {
    Database db = await database;
    int deletedRows = await db.delete(
      'mcq',
      where: 'id = ?',
      whereArgs: [mcqId],
    );
    await db.delete(
      'option',
      where: 'mcqId = ?',
      whereArgs: [mcqId],
    );

    return deletedRows;
  }
  Future<List<int>> getAllMcqIds() async {
    Database db = await database;
    List<Map<String, dynamic>> mcqIds = await db.query('mcq', columns: ['id']);
    List<int> ids = mcqIds.map((map) => map['id'] as int).toList();
    return ids;
  }



//
  // Future<int> removeIncome(int? id) async {
  //   Database db = await instance.database;
  //   return await db.delete('incomes', where: 'id = ?', whereArgs: [id]);
  // }
  //
  // Future<int> updateIncome(IncomeType income) async {
  //   Database db = await instance.database;
  //   return await db.update('incomes', income.toMap(),
  //       where: "id = ?", whereArgs: [income.id]);
  // }
  //
  //
  // // expense =========================================
  //
  // Future<List<ExpenseType>> getExpense() async {
  //   Database db = await instance.database;
  //   var expense = await db.query('expense');
  //   List<ExpenseType> expenseList =
  //   expense.isNotEmpty ? expense.map((c) => ExpenseType.fromMap(c)).toList() : [];
  //   return expenseList;
  // }
  //
  // Future<int> addExpense(ExpenseType expense) async {
  //   Database db = await instance.database;
  //   var response = await db.insert('expense', expense.toMap());
  //   return response;
  // }
  //
  // Future<int> removeExpense(int? id) async {
  //   Database db = await instance.database;
  //   return await db.delete('expense', where: 'id = ?', whereArgs: [id]);
  // }
  //
  // Future<int> updateExpense(ExpenseType expense) async {
  //   Database db = await instance.database;
  //   return await db.update('expense', expense.toMap(),
  //       where: "id = ?", whereArgs: [expense.id]);
  // }
  //
  // // ====================== assets================
  //
  // Future<List<AssetsType>> getInvestment() async {
  //   Database db = await instance.database;
  //   // var assets = await db.query('assets');
  //   var assets = await db.rawQuery('SELECT * FROM assets WHERE category = ?', ['Investment']);
  //   List<AssetsType> investmentList =
  //   assets.isNotEmpty ? assets.map((c) => AssetsType.fromMap(c)).toList() : [];
  //   return investmentList;
  // }
  // Future<List<AssetsType>> getDeposit() async {
  //   Database db = await instance.database;
  //   var assets = await db.rawQuery('SELECT * FROM assets WHERE category = ?', ['Deposit']);
  //   List<AssetsType> depositList =
  //   assets.isNotEmpty ? assets.map((c) => AssetsType.fromMap(c)).toList() : [];
  //   return depositList;
  // }
  // Future<List<AssetsType>> getLent() async {
  //   Database db = await instance.database;
  //   var assets = await db.rawQuery('SELECT * FROM assets WHERE category = ?', ['Lent']);
  //   List<AssetsType> lentList =
  //   assets.isNotEmpty ? assets.map((c) => AssetsType.fromMap(c)).toList() : [];
  //   return lentList;
  // }
  //
  // Future<int> addAssets(AssetsType asset) async {
  //   Database db = await instance.database;
  //   var response = await db.insert('assets', asset.toMap());
  //   return response;
  // }
  //
  // Future<int> removeAsset(int? id) async {
  //   Database db = await instance.database;
  //   return await db.delete('assets', where: 'id = ?', whereArgs: [id]);
  // }
  //
  // Future<int> updateAsset(AssetsType asset) async {
  //   Database db = await instance.database;
  //   return await db.update('assets', asset.toMap(),
  //       where: "id = ?", whereArgs: [asset.id]);
  // }
}

