import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';
import '../models/models.dart';

class DatabaseHelper {
  // 1
  static const _databaseName = 'MyRecipes.db';
  static const _databaseVersion = 1;

// 2
  static const recipeTable = 'Recipe';
  static const ingredientTable = 'Ingredient';
  static const recipeId = 'recipeId';
  static const ingredientId = 'ingredientId';

// 3
  static late BriteDatabase _streamDatabase;

// make this a singleton class
// 4
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
// 5
  static var lock = Lock();

// only have a single app-wide reference to the database
// 6
  static Database? _database;

// TODO: Add create database code here

// SQL code to create the database table
// 1
  Future _onCreate(Database db, int version) async {
    // 2
    await db.execute('''
        CREATE TABLE $recipeTable (
          $recipeId INTEGER PRIMARY KEY,
          label TEXT,
          image TEXT,
          url TEXT,
          calories REAL,
          totalWeight REAL,
          totalTime REAL
        )
        ''');
    // 3
    await db.execute('''
        CREATE TABLE $ingredientTable (
          $ingredientId INTEGER PRIMARY KEY,
          $recipeId INTEGER,
          name TEXT,
          weight REAL
        )
        ''');
  }

// TODO: Add code to open database
// this opens the database (and creates it if it doesn't exist)
// 1
  Future<Database> _initDatabase() async {
    // 2
    final documentsDirectory = await getApplicationDocumentsDirectory();

    // 3
    final path = join(documentsDirectory.path, _databaseName);

    // 4
    // TODO: Remember to turn off debugging before deploying app to store(s).
    Sqflite.setDebugModeOn(true);

    // 5
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

// TODO: Add initialize getter here
// 1
  Future<Database> get database async {
    // 2
    if (_database != null) return _database!;
    // Use this object to prevent concurrent access to data
    // 3
    await lock.synchronized(() async {
      // lazily instantiate the db the first time it is accessed
      // 4
      if (_database == null) {
        // 5
        _database = await _initDatabase();
        // 6
        _streamDatabase = BriteDatabase(_database!);
      }
    });
    return _database!;
  }

// TODO: Add getter for streamDatabase
// 1
  Future<BriteDatabase> get streamDatabase async {
    // 2
    await database;
    return _streamDatabase;
  }

// TODO: Add parseRecipes here
  List<Recipe> parseRecipes(List<Map<String, dynamic>> recipeList) {
    final recipes = <Recipe>[];
    // 1
    recipeList.forEach((recipeMap) {
      // 2
      final recipe = Recipe.fromJson(recipeMap);
      // 3
      recipes.add(recipe);
    });
    // 4
    return recipes;
  }

  List<Ingredient> parseIngredients(List<Map<String, dynamic>> ingredientList) {
    final ingredients = <Ingredient>[];
    ingredientList.forEach((ingredientMap) {
      // 5
      final ingredient = Ingredient.fromJson(ingredientMap);
      ingredients.add(ingredient);
    });
    return ingredients;
  }

// TODO: Add findAppRecipes here
  Future<List<Recipe>> findAllRecipes() async {
    // 1
    final db = await instance.streamDatabase;
    // 2
    final recipeList = await db.query(recipeTable);
    // 3
    final recipes = parseRecipes(recipeList);
    return recipes;
  }

// TODO: Add watchAllRecipes() here
  Stream<List<Recipe>> watchAllRecipes() async* {
    final db = await instance.streamDatabase;
    // 1
    yield* db
        // 2
        .createQuery(recipeTable)
        // 3
        .mapToList((row) => Recipe.fromJson(row));
  }

// TODO: Add watchAllIngredients() here
  Stream<List<Ingredient>> watchAllIngredients() async* {
    final db = await instance.streamDatabase;
    yield* db
        .createQuery(ingredientTable)
        .mapToList((row) => Ingredient.fromJson(row));
  }

// TODO: Add findRecipeByID() here
  Future<Recipe> findRecipeById(int id) async {
    final db = await instance.streamDatabase;
    final recipeList = await db.query(recipeTable, where: 'id = $id');
    final recipes = parseRecipes(recipeList);
    return recipes.first;
  }

// TODO: Put findAllIngredients() here
  Future<List<Ingredient>> findAllIngredients() async {
    final db = await instance.streamDatabase;
    final ingredientList = await db.query(ingredientTable);
    final ingredients = parseIngredients(ingredientList);
    return ingredients;
  }

// TODO: findRecipeIngredients() goes here
  Future<List<Ingredient>> findRecipeIngredients(int recipeId) async {
    final db = await instance.streamDatabase;
    final ingredientList =
        await db.query(ingredientTable, where: 'recipeId = $recipeId');
    final ingredients = parseIngredients(ingredientList);
    return ingredients;
  }

// TODO: Insert methods go here

}
