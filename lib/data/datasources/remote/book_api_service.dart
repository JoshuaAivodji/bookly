import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:bookly/data/models/book_model.dart';

part 'book_api_service.g.dart';

@RestApi()
abstract class BookApiService {
  factory BookApiService(Dio dio, {String baseUrl}) = _BookApiService;

  @GET('/volumes')
  Future<HttpResponse<Book>> getBooks({
    @Query('q') String query = 'books',
    @Query('startIndex') int startIndex = 0,
    @Query('maxResults') int maxResults = 20,
  });

  @GET('/volumes')
  Future<HttpResponse<Book>> searchBooks(@Query('q') String query);
}
