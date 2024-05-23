import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:wolvesvn/models/account.dart';
import 'package:wolvesvn/models/doitac.dart';
import 'package:wolvesvn/models/quangcao.dart';
import 'package:wolvesvn/models/sangiaodich.dart';
import 'package:wolvesvn/models/tongpip.dart';
import 'package:wolvesvn/models/video.dart';
import 'package:wolvesvn/models/vip.dart';

import '../models/rating.dart';
import '../models/fxsymbol.dart';
import '../models/san.dart';
import '../models/wolves_news.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://139.99.116.68/")
abstract class ApiServices {
  factory ApiServices(Dio dio) = _ApiServices;

  @POST('/account/login')
  Future<List<Account>> login(
      @Query("email") String email, @Query('password') String password);

  @POST('account/register')
  Future register(@Body() Account account);

  @GET('/api/Symbol')
  Future<List<FxSymbol>> getSymbols();

  @POST('account/forgot-password')
  Future forgotAccount(@Query("email") String email);

  @GET("videos/get")
  Future<List<Video>> getVideos();

  @GET("news-wolves/get")
  Future<List<WolvesNews>> getWolvesNews(@Query("dateTime") String dateTime);

  @GET("sangiaodich/get")
  Future<List<SanGiaoDich>> getSanGiaoDich();
  @GET("sangiaodich/getbyid")
  Future<SanGiaoDich> getSanById(@Query("id") int id);

  @GET("vip/get-vip")
  Future<List<Vip>> getVip(@Query("idAccount") int id);

  @POST("account/update-account")
  Future updateAccount(@Body() Account account);

  @POST("account/change-password")
  Future changePassword(
      @Query("email") String email,
      @Query("oldPassword") String oldPassword,
      @Query("newPassword") String newPassword);

  @GET('api/DoiTac')
  Future<List<DoiTac>> getDoiTacs();

  @POST('account/block')
  Future blockAccount(@Query("id") int id);

  @GET('quangcao/get-quang-cao')
  Future<List<QuangCao>> getQuangCaos();

  @GET("tongpip/get")
  Future<List<TongPip>> getTongPips();

  @GET("api/Sans")
  Future<List<San>> getSans();

  @GET('api/Ratings')
  Future<List<Rating>> getRatings(@Query("idSan") int idSan);

  @GET('news-wolves/get-by-id')
  Future<WolvesNews> getNewsById(@Query("Id") int id);
}
