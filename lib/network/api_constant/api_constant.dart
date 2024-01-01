//Base URL
const kBaseURL = "https://api.themoviedb.org/3";

//End Point
const kEndPointForGenres = "/genre/movie/list";
const kEndPointForMovieByGenres = "/discover/movie";
const kEndPointForSimilarMovies = "/movie/{$kPathParamsMovieID}/similar";
const kEndPointForPopularMovies = "/movie/popular";
const kEndPointForActors = "/person/popular";
const kEndPointForMovieTopRated = "/movie/top_rated";
const kEndPointForMovieDetails = "/movie/{$kPathParamsMovieID}";
const kEndPointForSearchMovie = "/search/movie";
const kEndPointForCredits = "/movie/{$kPathParamsMovieID}/credits";
const kEndPointForActorDetails = "/person/{$kPathParamsActorID}";
const kEndPointForMovieVideo = "/movie/{$kPathParamsMovieID}/videos";

//Query Params Keys
const kQueryParamsApiKey = "api_key";
const kQueryParamsKeyForMovieByGenres = "with_genres";
const kQueryParamsKeyForSearchMovie = "query";

//Path Params Keys
const kPathParamsMovieID = "movieID";
const kPathParamsActorID = "actorID";

//Api Value
const kAPIValue = "6ba57a8fa213613268b61de49d70fffe";
