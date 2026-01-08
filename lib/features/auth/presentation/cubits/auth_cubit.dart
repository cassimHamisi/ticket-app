import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.login(username, password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void logout() {
    emit(AuthInitial());
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    try {
      if (json['type'] == 'authenticated') {
        return AuthAuthenticated(
          User(
            id: json['user']['id'] as int,
            username: json['user']['username'] as String,
            email: json['user']['email'] as String,
          ),
        );
      }
    } catch (_) {}
    return AuthInitial();
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if (state is AuthAuthenticated) {
      return {
        'type': 'authenticated',
        'user': {
          'id': state.user.id,
          'username': state.user.username,
          'email': state.user.email,
        },
      };
    }
    return null;
  }
}
