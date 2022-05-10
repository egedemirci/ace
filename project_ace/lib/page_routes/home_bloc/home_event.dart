part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeInitialLoad extends HomeEvent {
  const HomeInitialLoad();

  @override
  String toString() => 'Home Page loading...';
}

class HomeIncrementButtonTapped extends HomeEvent {
  const HomeIncrementButtonTapped();

  @override
  String toString() => 'Home: increment button tapped!';
}

class HomeDecrementButtonTapped extends HomeEvent {
  const HomeDecrementButtonTapped();

  @override
  String toString() => 'Home: decrement button tapped!';
}

class HomeToggleThemeButtonTapped extends HomeEvent {
  const HomeToggleThemeButtonTapped();

  @override
  String toString() => 'Home: toggle theme button tapped!';
}
