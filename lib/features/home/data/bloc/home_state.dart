part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  final List<ConnectivityResult> connectivityResult;
  const HomeState({this.connectivityResult = const [ConnectivityResult.none]});

  bool get isOnline => connectivityResult.contains(ConnectivityResult.wifi);
}

final class HomeInitial extends HomeState {
  const HomeInitial({super.connectivityResult});
}

final class HomeLoading extends HomeState {
  const HomeLoading({super.connectivityResult});
}

final class HomeLoadedTruck extends HomeState {
  final List<TransaksiMaterialModel> trukSortasi;

  const HomeLoadedTruck({required this.trukSortasi, super.connectivityResult});
}

final class HomeLoadedSortasi extends HomeState {
  final SortasiPaginationModel sortasi;
  final int currentPage;
  final int totalPage;

  const HomeLoadedSortasi({
    required this.sortasi,
    super.connectivityResult,
    required this.currentPage,
    required this.totalPage,
  });
}

final class HomeError extends HomeState {
  final String message;

  const HomeError(this.message, {super.connectivityResult});
}
