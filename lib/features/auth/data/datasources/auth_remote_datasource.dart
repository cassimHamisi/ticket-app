import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource({Dio? dio})
      : dio = dio ?? Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  Future<UserModel> login(String username, String password) async {
    try {
      // Mock login - in real app, you'd send credentials
      final response = await dio.get(ApiConstants.loginEndpoint);
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}
