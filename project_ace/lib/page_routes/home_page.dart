// AFU was here
// App Level State Management
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_ace/page_routes/home_bloc/home_bloc.dart';

import '../services/analytics.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.analytics})
      : super(key: key);
  final FirebaseAnalytics analytics;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    setCurrentScreen(widget.analytics, "Home Page View", "homePageView");
    return BlocProvider(
      create: (context) => HomeBloc()..add(const HomeInitialLoad()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoaded) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: state.isDarkMode ? Colors.black : Colors.white,
                appBar: AppBar(
                  title: Text(widget.title),
                  backgroundColor: state.isDarkMode ? Colors.grey : Colors.blue,
                ),
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OutlinedButton(
                          onPressed: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(const HomeToggleThemeButtonTapped());
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  state.isDarkMode
                                      ? Colors.white
                                      : Colors.black)),
                          child: state.isDarkMode
                              ? const Text("Toggle dark mode")
                              : const Text("Toggle light mode"),
                        ),
                        Text(
                          'You have pushed the button this many times:',
                          style: TextStyle(
                              color: state.isDarkMode
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        Text(
                          '${state.counter}',
                          style: TextStyle(
                              color: state.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        BlocProvider.of<HomeBloc>(context)
                            .add(const HomeIncrementButtonTapped());
                      },
                      tooltip: 'Increment',
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(width: 30),
                    FloatingActionButton(
                      onPressed: () {
                        BlocProvider.of<HomeBloc>(context)
                            .add(const HomeDecrementButtonTapped());
                      },
                      tooltip: 'Decrement',
                      child: const Icon(Icons.remove),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
