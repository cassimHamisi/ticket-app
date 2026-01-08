import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit() : super(const AuthState());

  Future<void> login() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    await Future<void>.delayed(const Duration(milliseconds: 400));
    emit(state.copyWith(isAuthenticated: true, isLoading: false));
  }

  Future<void> logout() async {
    emit(state.copyWith(isAuthenticated: false));
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState(
      isAuthenticated: json['isAuthenticated'] as bool? ?? false,
    );
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return {'isAuthenticated': state.isAuthenticated};
  }
}
