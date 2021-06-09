import 'package:hive/hive.dart';
import 'package:popcorn/data/tables/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<void>saveFavoriteMovie(MovieTable movieTable);
  Future<void>deleteFavoriteMovie(int movieId);
  Future<List<MovieTable>>getFavfetchFavorites();
  Future<bool>checkIfFavoriteMovie(int movieId);
}
class MovieLocalDataSourceImpl extends MovieLocalDataSource{
  @override
  Future<bool> checkIfFavoriteMovie(int movieId) async{
    
   final movieBox=await Hive.openBox('FavoriteMovies');
   return movieBox.containsKey(movieId);
  }

  @override
  Future<void> deleteFavoriteMovie(int movieId) async{
    final movieBox=await Hive.openBox('FavoriteMovies');
    movieBox.delete(movieId);
  }

  @override
  Future<List<MovieTable>> getFavfetchFavorites() async{
    final movieBox=await Hive.openBox('FavoriteMovies');
    final movieIds=movieBox.keys;
    final List<MovieTable> movies=[];
     movieIds.forEach((movieId) { 
       movies.add(movieBox.get(movieId));
     });
     return movies;
  }

  @override
  Future<void> saveFavoriteMovie(MovieTable movieTable) async{
   final movieBox=await Hive.openBox('FavoriteMovies');
   await movieBox.put(movieTable.id, movieTable);
  }

}