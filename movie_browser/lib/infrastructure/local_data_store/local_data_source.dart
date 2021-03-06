import 'package:hive/hive.dart';

import '../../models/movie_details.dart';
import '../../models/search_result.dart';
import 'local_data_interface.dart';

const String MOVIE_DETAILS_BOX = 'MovieDetailsBox';
const String SEARCH_RESULT_BOX = 'SearchResultBox';

class LocalDataSource implements LocalDataInterface {
  final Box movieDetailsBox;
  final Box searchBox;

  LocalDataSource({
    this.movieDetailsBox,
    this.searchBox,
  });

  @override
  SearchResult searchMovie(String title, int page) {
    return searchBox.get('T-$title::P-$page');
  }

  @override
  Future<void> cacheSearchResult(SearchResult result) async {
    await searchBox.put('T-${result.title}::P-${result.page}', result);
  }

  @override
  MovieDetails getMovieDetails(String id) {
    return movieDetailsBox.get('$id');
  }

  @override
  Future<void> cacheMovieDetails(MovieDetails movieDetails) async {
    await movieDetailsBox.put('${movieDetails.imdbmId}', movieDetails);
  }
}
