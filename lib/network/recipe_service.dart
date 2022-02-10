// 1
import 'package:chopper/chopper.dart';
import 'recipe_model.dart';
import 'model_response.dart';
import 'model_converter.dart';

const String apiKey = '0c177b9cd32f8c3261d0c205f263d398';
const String apiId = 'ccafb53c';
const String apiUrl = 'https://api.edamam.com';

// TODO: Add @ChopperApi() here
// 1
@ChopperApi()
// 2
abstract class RecipeService extends ChopperService {
  // 3
  @Get(path: 'search')
  // 4
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
      // 5
      @Query('q') String query,
      @Query('from') int from,
      @Query('to') int to);
// TODO: Add create()
}
// TODO: Add _addQuery()
