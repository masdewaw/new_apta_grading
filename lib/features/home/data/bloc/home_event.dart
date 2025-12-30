part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeLoadTruckRequested extends HomeEvent {}

final class HomeLoadSortasiRequested extends HomeEvent {}

final class HomeChangePageRequested extends HomeEvent {
  final int page; // 0-based
  HomeChangePageRequested(this.page);
}

final class HomeConnectivityChanged extends HomeEvent {
  final List<ConnectivityResult> result;

  HomeConnectivityChanged(this.result);
}
