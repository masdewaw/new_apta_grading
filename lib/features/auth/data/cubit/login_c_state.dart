part of 'login_c_cubit.dart';

@immutable
sealed class LoginCState {
  final bool passwordVisible;
  final String versionApp;

  const LoginCState({this.passwordVisible = true, this.versionApp = ''});
}

final class LoginCInitial extends LoginCState {
  const LoginCInitial({super.passwordVisible});
}

final class LoginCInfo extends LoginCState {
  const LoginCInfo({super.versionApp});
}
