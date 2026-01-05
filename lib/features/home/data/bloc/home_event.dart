part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeLoadTruckRequested extends HomeEvent {}

final class HomeLoadSortasiRequested extends HomeEvent {}

final class HomeChangePageRequested extends HomeEvent {
  final int page;
  HomeChangePageRequested(this.page);
}

final class HomeConnectivityChanged extends HomeEvent {
  final List<ConnectivityResult> result;

  HomeConnectivityChanged(this.result);
}

final class HomeLoadAsistenRequested extends HomeEvent {}

final class HomeLoadJenisBuahRequested extends HomeEvent {}

/// Event untuk menyimpan pilihan asisten dan truk yang dipilih
final class HomeSelectAsistenRequested extends HomeEvent {
  final List<AsistenSortasiModel> selectedAsisten;
  final TransaksiMaterialModel selectedTruk;

  HomeSelectAsistenRequested({
    required this.selectedAsisten,
    required this.selectedTruk,
  });
}

/// Event untuk clear pilihan asisten
final class HomeClearSelectedAsisten extends HomeEvent {}
