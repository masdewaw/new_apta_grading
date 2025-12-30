part of 'home_c_cubit.dart';

@immutable
sealed class HomeCState {
  final int selectedTab;
  final String userName;

  const HomeCState({required this.selectedTab, this.userName = ''});
}

final class HomeCInitial extends HomeCState {
  const HomeCInitial({required super.selectedTab, super.userName});
}
