import 'package:moor_flutter/moor_flutter.dart';
import '../models/models.dart';

part 'moor_db.g.dart';

// TODO: Add MoorRecipe table definition here
// 1
class MoorRecipe extends Table {
  // 2
  IntColumn get id => integer().autoIncrement()();

  // 3
  TextColumn get label => text()();

  TextColumn get image => text()();

  TextColumn get url => text()();

  RealColumn get calories => real()();

  RealColumn get totalWeight => real()();

  RealColumn get totalTime => real()();
}

// TODO: Add MoorIngredient table definition here
class MoorIngredient extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get recipeId => integer()();

  TextColumn get name => text()();

  RealColumn get weight => real()();
}

// TODO: Add @UseMoor() and RecipeDatabase() here

// 1
@UseMoor(tables: [MoorRecipe, MoorIngredient], daos: [RecipeDao, IngredientDao])
// 2
class RecipeDatabase extends _$RecipeDatabase {
  RecipeDatabase()
      // 3
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'recipes.sqlite', logStatements: true));

  // 4
  @override
  int get schemaVersion => 1;
}

// TODO: Add RecipeDao here

// TODO: Add IngredientDao

// TODO: Add moorRecipeToRecipe here

// TODO: Add MoorRecipeData here

// TODO: Add moorIngredientToIngredient and MoorIngredientCompanion here
