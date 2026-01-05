part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  final List<ConnectivityResult> connectivityResult;
  final List<AsistenSortasiModel> asistenSortasi;
  final List<JenisBuahModel> jenisBuah;
  final List<AsistenSortasiModel> selectedAsisten;
  final TransaksiMaterialModel? selectedTruk;

  const HomeState({
    this.connectivityResult = const [ConnectivityResult.none],
    this.asistenSortasi = const [],
    this.jenisBuah = const [],
    this.selectedAsisten = const [],
    this.selectedTruk,
  });

  bool get isOnline => connectivityResult.contains(ConnectivityResult.wifi);
  bool get hasSelectedAsisten => selectedAsisten.isNotEmpty;
}

final class HomeInitial extends HomeState {
  const HomeInitial({
    super.connectivityResult,
    super.asistenSortasi,
    super.jenisBuah,
    super.selectedAsisten,
    super.selectedTruk,
  });
}

final class HomeLoading extends HomeState {
  const HomeLoading({
    super.connectivityResult,
    super.asistenSortasi,
    super.jenisBuah,
    super.selectedAsisten,
    super.selectedTruk,
  });
}

final class HomeLoadedTruck extends HomeState {
  final List<TransaksiMaterialModel> trukSortasi;

  const HomeLoadedTruck({
    required this.trukSortasi,
    super.connectivityResult,
    super.asistenSortasi,
    super.jenisBuah,
    super.selectedAsisten,
    super.selectedTruk,
  });
}

final class HomeLoadedSortasi extends HomeState {
  final SortasiPaginationModel sortasi;
  final int currentPage;
  final int totalPage;

  const HomeLoadedSortasi({
    required this.sortasi,
    super.connectivityResult,
    super.asistenSortasi,
    super.jenisBuah,
    super.selectedAsisten,
    super.selectedTruk,
    required this.currentPage,
    required this.totalPage,
  });
}

final class HomeError extends HomeState {
  final String message;

  const HomeError(
    this.message, {
    super.connectivityResult,
    super.asistenSortasi,
    super.jenisBuah,
    super.selectedAsisten,
    super.selectedTruk,
  });
}
