import 'dart:async';
import '../models/models.dart';

import '../repository.dart';
import 'moor_db.dart';

class MoorRepository extends Repository {
  // 1
  late RecipeDatabase recipeDatabase;
  // 2
  late RecipeDao _recipeDao;
  // 3
  late IngredientDao _ingredientDao;
  // 3
  Stream<List<Ingredient>>? ingredientStream;
  // 4
  Stream<List<Recipe>>? recipeStream;

  // TODO: Add findAllRecipes()
  // TODO: Add watchAllRecipes()
  // TODO: Add watchAllIngredients()
  // TODO: Add findRecipeById()
  // TODO: Add findAllIngredients()
  // TODO: Add findRecipeIngredients()
  // TODO: Add insertRecipe()
  // TODO: Add insertIngredients()
  // TODO: Add Delete methods

  @override
  Future init() async {
    // 6
    recipeDatabase = RecipeDatabase();
    // 7
    _recipeDao = recipeDatabase.recipeDao;
    _ingredientDao = recipeDatabase.ingredientDao;
  }

  @override
  void close() {
    // 8
    recipeDatabase.close();
  }
}
