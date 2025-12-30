import 'package:new_apta_grading/core/network/instance/auth_instance.dart';
import 'package:new_apta_grading/features/auth/data/model/login_model.dart';

/// Abstract repository interface for authentication
abstract class IAuthRepository {
  /// Performs login with email and password
  Future<LoginResponseModel> login(LoginInputModel input);
}

/// Implementation of [IAuthRepository] that uses [AuthAPI] for remote calls
class AuthRepository implements IAuthRepository {
  final AuthAPI _authAPI;

  AuthRepository({AuthAPI? authAPI}) : _authAPI = authAPI ?? AuthAPI();

  @override
  Future<LoginResponseModel> login(LoginInputModel input) async {
    return await _authAPI.login(input);
  }
}
