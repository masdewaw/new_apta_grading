import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:new_apta_grading/core/theme/themes.dart';
import 'package:new_apta_grading/core/utils/extension.dart';
import 'package:new_apta_grading/core/utils/local_storage.dart';
import 'package:new_apta_grading/features/auth/data/bloc/auth_bloc.dart';
import 'package:new_apta_grading/features/auth/data/cubit/login_c_cubit.dart';
import 'package:new_apta_grading/features/home/data/bloc/home_bloc.dart';
import 'package:new_apta_grading/features/home/data/cubit/home_c_cubit.dart';

part './features/splash/presentation/pages/splash_page.dart';
part './features/auth/presentation/pages/login_page.dart';
part './features/home/presentation/pages/home_page.dart';
part './features/setting/presentation/pages/setting_page.dart';
