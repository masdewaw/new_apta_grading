import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:new_apta_grading/core/utils/local_storage.dart';

part 'home_c_state.dart';

class HomeCCubit extends Cubit<HomeCState> {
  HomeCCubit() : super(const HomeCInitial(selectedTab: 0));

  void init() async {
    final String? name = await getStringStorage(StorageKey.name);
    emit(
      HomeCInitial(selectedTab: state.selectedTab, userName: name ?? 'User'),
    );
  }

  void changeTab(int tab) {
    emit(HomeCInitial(selectedTab: tab, userName: state.userName));
  }
}
