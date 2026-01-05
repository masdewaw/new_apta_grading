import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:new_apta_grading/core/repository/sortasi_repository.dart';
import 'package:new_apta_grading/features/home/data/model/asisten_sortasi_model.dart';
import 'package:new_apta_grading/features/home/data/model/jenis_buah_model.dart';
import 'package:new_apta_grading/features/home/data/model/sortasi_pagination_model.dart';
import 'package:new_apta_grading/features/home/data/model/transaksi_material_sortasi_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  List<ConnectivityResult> _connectivity = const [ConnectivityResult.none];
  List<AsistenSortasiModel> _asistenSortasi = const [];
  List<JenisBuahModel> _jenisBuah = const [];
  List<AsistenSortasiModel> _selectedAsisten = const [];
  TransaksiMaterialModel? _selectedTruk;
  int _currentPage = 0;
  int _totalPage = 1;

  HomeBloc() : super(HomeInitial()) {
    on<HomeConnectivityChanged>(_onConnectivityChanged);
    on<HomeLoadTruckRequested>(_loadDataTruck);
    on<HomeChangePageRequested>(_onChangePageRequested);
    on<HomeLoadSortasiRequested>(_loadDataSortasi);
    on<HomeLoadAsistenRequested>(_loadAsistenSortasi);
    on<HomeLoadJenisBuahRequested>(_onLoadJenisBuah);
    on<HomeSelectAsistenRequested>(_onSelectAsisten);
    on<HomeClearSelectedAsisten>(_onClearSelectedAsisten);

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
    _emitCurrentState(emit);
  }

  void _emitCurrentState(Emitter<HomeState> emit) {
    if (state is HomeLoading) {
      emit(
        HomeLoading(
          connectivityResult: _connectivity,
          asistenSortasi: _asistenSortasi,
          jenisBuah: _jenisBuah,
          selectedAsisten: _selectedAsisten,
          selectedTruk: _selectedTruk,
        ),
      );
    } else if (state is HomeLoadedTruck) {
      final curr = state as HomeLoadedTruck;
      emit(
        HomeLoadedTruck(
          trukSortasi: curr.trukSortasi,
          connectivityResult: _connectivity,
          asistenSortasi: _asistenSortasi,
          jenisBuah: _jenisBuah,
          selectedAsisten: _selectedAsisten,
          selectedTruk: _selectedTruk,
        ),
      );
    } else if (state is HomeLoadedSortasi) {
      final curr = state as HomeLoadedSortasi;
      emit(
        HomeLoadedSortasi(
          sortasi: curr.sortasi,
          connectivityResult: _connectivity,
          asistenSortasi: _asistenSortasi,
          jenisBuah: _jenisBuah,
          selectedAsisten: _selectedAsisten,
          selectedTruk: _selectedTruk,
          currentPage: curr.currentPage,
          totalPage: curr.totalPage,
        ),
      );
    } else if (state is HomeError) {
      final curr = state as HomeError;
      emit(
        HomeError(
          curr.message,
          connectivityResult: _connectivity,
          asistenSortasi: _asistenSortasi,
          jenisBuah: _jenisBuah,
          selectedAsisten: _selectedAsisten,
          selectedTruk: _selectedTruk,
        ),
      );
    }
  }

  Future<void> _onSelectAsisten(
    HomeSelectAsistenRequested event,
    Emitter<HomeState> emit,
  ) async {
    _selectedAsisten = event.selectedAsisten;
    _selectedTruk = event.selectedTruk;
    _emitCurrentState(emit);
  }

  Future<void> _onClearSelectedAsisten(
    HomeClearSelectedAsisten event,
    Emitter<HomeState> emit,
  ) async {
    _selectedAsisten = const [];
    _selectedTruk = null;
    _selectedTruk = null;
    _emitCurrentState(emit);
  }

  Future<void> _onLoadJenisBuah(
    HomeLoadJenisBuahRequested event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final result = await SortasiRepository().getJenisBuah();
      _jenisBuah = result;
      _emitCurrentState(emit);
    } catch (e) {
      debugPrint('Error loading jenis buah: $e');
    }
  }

  Future<void> _loadAsistenSortasi(
    HomeLoadAsistenRequested event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final result = await SortasiRepository().getAsistenSortasi();
      _asistenSortasi = result;
      _emitCurrentState(emit);
    } catch (e) {
      debugPrint('Error loading asisten sortasi: $e');
    }
  }

  Future<void> _loadDataTruck(
    HomeLoadTruckRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      HomeLoading(
        connectivityResult: _connectivity,
        asistenSortasi: _asistenSortasi,
        jenisBuah: _jenisBuah,
        selectedAsisten: _selectedAsisten,
        selectedTruk: _selectedTruk,
      ),
    );
    try {
      final result = await SortasiRepository().getTrukSortasi();
      emit(
        HomeLoadedTruck(
          trukSortasi: result,
          connectivityResult: _connectivity,
          asistenSortasi: _asistenSortasi,
          jenisBuah: _jenisBuah,
          selectedAsisten: _selectedAsisten,
          selectedTruk: _selectedTruk,
        ),
      );
    } catch (e) {
      emit(
        HomeError(
          e.toString(),
          connectivityResult: _connectivity,
          asistenSortasi: _asistenSortasi,
          jenisBuah: _jenisBuah,
          selectedAsisten: _selectedAsisten,
          selectedTruk: _selectedTruk,
        ),
      );
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
    emit(
      HomeLoading(
        connectivityResult: _connectivity,
        asistenSortasi: _asistenSortasi,
        jenisBuah: _jenisBuah,
        selectedAsisten: _selectedAsisten,
        selectedTruk: _selectedTruk,
      ),
    );
    try {
      final result = await SortasiRepository().getDataSortasiPagination(
        _currentPage,
      );
      debugPrint('TOTAL PAGES API: ${result.totalPages}');

      _currentPage = result.page;
      _totalPage = result.totalPages;
      emit(
        HomeLoadedSortasi(
          sortasi: result,
          connectivityResult: _connectivity,
          asistenSortasi: _asistenSortasi,
          jenisBuah: _jenisBuah,
          selectedAsisten: _selectedAsisten,
          selectedTruk: _selectedTruk,
          currentPage: _currentPage,
          totalPage: _totalPage,
        ),
      );
    } catch (e) {
      emit(
        HomeError(
          e.toString(),
          connectivityResult: _connectivity,
          asistenSortasi: _asistenSortasi,
          jenisBuah: _jenisBuah,
          selectedAsisten: _selectedAsisten,
          selectedTruk: _selectedTruk,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
