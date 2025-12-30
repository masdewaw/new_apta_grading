import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'login_c_state.dart';

class LoginCCubit extends Cubit<LoginCState> {
  LoginCCubit() : super(LoginCInitial());

  void togglePasswordVisibility() {
    emit(LoginCInitial(passwordVisible: !state.passwordVisible));
  }

  void initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    emit(LoginCInfo(versionApp: info.version));
  }
}
