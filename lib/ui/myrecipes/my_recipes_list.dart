import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../data/models/recipe.dart';
import '../../data/memory_repository.dart';

class MyRecipesList extends StatefulWidget {
  const MyRecipesList({Key? key}) : super(key: key);

  @override
  _MyRecipesListState createState() => _MyRecipesListState();
}

class _MyRecipesListState extends State<MyRecipesList> {
  // TODO: Update recipes declaration
  List<Recipe> recipes = [];

  // TODO: Remove initState()
  @override
  void initState() {
    super.initState();
    recipes = <String>[];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _buildRecipeList(context),
    );
  }

  Widget _buildRecipeList(BuildContext context) {
    // TODO: Add Consumer
    return ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (BuildContext context, int index) {
          // TODO: Add recipe definition
          return SizedBox(
            height: 100,
            child: Slidable(
              actionPane: const SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CachedNetworkImage(
                          // TODO: Replace imageUrl hardcoding
                          imageUrl:
                              'http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html',
                          height: 120,
                          width: 60,
                          fit: BoxFit.cover),
                      // TODO: Replace title hardcoding
                      title: const Text('Chicken Vesuvio'),
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                IconSlideAction(
                    caption: 'Delete',
                    color: Colors.transparent,
                    foregroundColor: Colors.black,
                    iconWidget: const Icon(Icons.delete, color: Colors.red),
                    // TODO: Update first onTap
                    onTap: () {})
              ],
              secondaryActions: <Widget>[
                IconSlideAction(
                    caption: 'Delete',
                    color: Colors.transparent,
                    foregroundColor: Colors.black,
                    iconWidget: const Icon(Icons.delete, color: Colors.red),
                    // TODO: Update second onTap
                    onTap: () {})
              ],
            ),
          );
        });
    // TODO: Add final brace and parenthesis
  }

  // TODO: Add deleteRecipe() here
  void deleteRecipe(MemoryRepository repository, Recipe recipe) async {
    if (recipe.id != null) {
      // 1
      repository.deleteRecipeIngredients(recipe.id!);
      // 2
      repository.deleteRecipe(recipe);
      // 3
      setState(() {});
    } else {
      print('Recipe id is null');
    }
  }
}
