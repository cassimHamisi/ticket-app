import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({AuthRemoteDataSource? remoteDataSource})
      : remoteDataSource = remoteDataSource ?? AuthRemoteDataSource();

  @override
  Future<User> login(String username, String password) async {
    final userModel = await remoteDataSource.login(username, password);
    return userModel.toEntity();
  }
}
