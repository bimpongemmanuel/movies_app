import 'package:http/http.dart';

class AllMoviesNetwork{
  // creatinag a method to get data from 
  
  getAllMovies() async{
    final response = await get(Uri.parse('https://ghibliapi.herokuapp.com/films'));



    // Check if the date is available
    if(response.statusCode == 200){
      print(response.body);
    }else{print(response.statusCode);}
  }
}