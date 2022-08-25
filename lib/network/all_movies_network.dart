import 'package:http/http.dart';
import 'package:my_movie_app/Models/movies_models.dart';

class AllMoviesNetwork{
  // creatinag a method to get data from 
  
 Future<List<MoviesModel>> getAllMovies() async{
    final response = await get(Uri.parse('https://ghibliapi.herokuapp.com/films'));



    // Check if the date is available
    if(response.statusCode == 200){
      print(response.body);
      return moviesModelFromJson(response.body);
    }else{
      throw{
        Exception('Failed to get data from API')
      };
  }
 }
}