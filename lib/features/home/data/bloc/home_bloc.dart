import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:new_apta_grading/core/repository/sortasi_repository.dart';
import 'package:new_apta_grading/features/home/data/model/sortasi_pagination_model.dart';
import 'package:new_apta_grading/features/home/data/model/transaksi_material_sortasi_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  List<ConnectivityResult> _connectivity = const [ConnectivityResult.none];
  int _currentPage = 0;
  int _totalPage = 1;

  HomeBloc() : super(HomeInitial()) {
    on<HomeConnectivityChanged>(_onConnectivityChanged);
    on<HomeLoadTruckRequested>(_loadDataTruck);
    on<HomeChangePageRequested>(_onChangePageRequested);
    on<HomeLoadSortasiRequested>(_loadDataSortasi);

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      result,
    ) {
      add(HomeConnectivityChanged(result));
    });

    Connectivity().checkConnectivity().then((result) {
      add(HomeConnectivityChanged(result));
    });
  }

  void _onConnectivityChanged(
    HomeConnectivityChanged event,
    Emitter<HomeState> emit,
  ) {
    _connectivity = event.result;
    if (state is HomeLoading) {
      emit(HomeLoading(connectivityResult: _connectivity));
    } else if (state is HomeLoadedTruck) {
      final curr = state as HomeLoadedTruck;
      emit(
        HomeLoadedTruck(
          trukSortasi: curr.trukSortasi,
          connectivityResult: _connectivity,
        ),
      );
    } else if (state is HomeLoadedSortasi) {
      final curr = state as HomeLoadedSortasi;
      emit(
        HomeLoadedSortasi(
          sortasi: curr.sortasi,
          connectivityResult: _connectivity,
          currentPage: curr.currentPage,
          totalPage: curr.totalPage,
        ),
      );
    } else if (state is HomeError) {
      final curr = state as HomeError;
      emit(HomeError(curr.message, connectivityResult: _connectivity));
    }
  }

  Future<void> _loadDataTruck(
    HomeLoadTruckRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading(connectivityResult: _connectivity));
    try {
      final result = await SortasiRepository().getTrukSortasi();
      emit(
        HomeLoadedTruck(trukSortasi: result, connectivityResult: _connectivity),
      );
    } catch (e) {
      emit(HomeError(e.toString(), connectivityResult: _connectivity));
    }
  }

  Future<void> _onChangePageRequested(
    HomeChangePageRequested event,
    Emitter<HomeState> emit,
  ) async {
    if (event.page < 0) return;
    if (event.page >= _totalPage) return;
    _currentPage = event.page;
    add(HomeLoadSortasiRequested());
  }

  Future<void> _loadDataSortasi(
    HomeLoadSortasiRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading(connectivityResult: _connectivity));
    try {
      final result = await SortasiRepository().getDataSortasiPagination(
        _currentPage,
      );

      _currentPage = result.page;
      _totalPage = result.totalPages;
      emit(
        HomeLoadedSortasi(
          sortasi: result,
          connectivityResult: _connectivity,
          currentPage: _currentPage,
          totalPage: _totalPage,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString(), connectivityResult: _connectivity));
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
