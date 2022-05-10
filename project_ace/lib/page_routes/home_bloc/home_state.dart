part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeLoaded extends HomeState {
  final int counter;
  final bool isDarkMode;

  const HomeLoaded({required this.counter, required this.isDarkMode});

  @override
  String toString() =>
      'Home loaded with counter: $counter and dark mode status: $isDarkMode';

  @override
  List<Object?> get props => [counter, isDarkMode];
}
