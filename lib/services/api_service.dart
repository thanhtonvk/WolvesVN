import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:wolvesvn/models/account.dart';
import 'package:wolvesvn/models/doitac.dart';
import 'package:wolvesvn/models/sangiaodich.dart';
import 'package:wolvesvn/models/video.dart';
import 'package:wolvesvn/models/vip.dart';

import '../models/wolves_news.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://wolves-vn.ddns.net/")
abstract class ApiServices {
  factory ApiServices(Dio dio) = _ApiServices;

  @POST('/account/login')
  Future<List<Account>> login(
      @Query("email") String email, @Query('password') String password);

  @POST('account/register')
  Future register(@Body() Account account);

  @GET('/Symbol/get-symbol')
  Future<String> getSymbols();

  @POST('account/forgot-password')
  Future forgotAccount(@Query("email") String email);

  @GET("videos/get")
  Future<List<Video>> getVideos();

  @GET("news-wolves/get")
  Future<List<WolvesNews>> getWolvesNews(@Query("dateTime") String dateTime);

  @GET("sangiaodich/get")
  Future<List<SanGiaoDich>> getSanGiaoDich();

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
}
