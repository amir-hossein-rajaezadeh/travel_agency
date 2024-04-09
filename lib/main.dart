import 'package:flutter/material.dart';
import 'package:travel_agency/cubit/app_cubit.dart';
import 'package:travel_agency/screens/home/home_page.dart';
import 'package:travel_agency/screens/search/search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (_, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const SearchPage(),
            transitionDuration: const Duration(milliseconds: 1200),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          );
        },
      ),
      GoRoute(
        path: '/homePage',
        pageBuilder: (_, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const HomePage(),
            transitionDuration: const Duration(milliseconds: 1200),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          );
        },
      )
    ],
  );
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: _router,
      ),
    );
  }
}
