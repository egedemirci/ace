import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int counter = 0;
  bool isDarkMode = false;

  HomeBloc() : super(const HomeLoaded(counter: 0, isDarkMode: false)) {
    on<HomeInitialLoad>((event, emit) async {
      var prefs = await SharedPreferences.getInstance();
      counter = prefs.getInt("counter") ?? 0;
      isDarkMode = prefs.getBool("darkThemeState") ?? false;
      emit(HomeLoaded(counter: counter, isDarkMode: isDarkMode));
    });
    on<HomeIncrementButtonTapped>((event, emit) async {
      counter++;
      var prefs = await SharedPreferences.getInstance();
      prefs.setInt("counter", counter);
      emit(HomeLoaded(counter: counter, isDarkMode: isDarkMode));
    });
    on<HomeDecrementButtonTapped>((event, emit) async {
      counter--;
      var prefs = await SharedPreferences.getInstance();
      prefs.setInt("counter", counter);
      emit(HomeLoaded(counter: counter, isDarkMode: isDarkMode));
    });
    on<HomeToggleThemeButtonTapped>((event, emit) async {
      isDarkMode = !isDarkMode;
      var prefs = await SharedPreferences.getInstance();
      prefs.setBool("darkThemeState", isDarkMode);
      emit(HomeLoaded(counter: counter, isDarkMode: isDarkMode));
    });
  }
}
