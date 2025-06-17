import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/manager/get_all_users_cubit/get_all_users_cubit.dart';
import '../../features/home/presentation/view/home_view.dart';
import '../../features/splash/presentation/view/onboarding_view.dart';
import '../../features/splash/presentation/view/splash_view.dart';
import '../../features/static_pages/presentation/views/select_language_view.dart';
import '../../features/user_details/presentation/manager/get_user_details_cubit/get_user_details_cubit.dart';
import '../../features/user_details/presentation/view/user_details_view.dart';

abstract class AppRouter {
  static const kOnBoardingView = '/kOnBoardingView';
  static const kHomeView = '/kHomeView';
  static const kSelectLanguageView = '/kSelectLanguageView';
  static const kUserDetailsView = '/kUserDetailsView';

  Duration animationDuration = const Duration(milliseconds: 300);
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 400),
            key: state.pageKey,
            child: const SplashView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(
                      curve: Curves.easeInOutCirc,
                    ).animate(animation),
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: kOnBoardingView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 400),
            key: state.pageKey,
            child: const OnboardingView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(
                      curve: Curves.easeInOutCirc,
                    ).animate(animation),
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: kHomeView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 400),
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => GetAllUsersCubit()..loadUsers(),
              child: const HomeView(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(
                      curve: Curves.easeInOutCirc,
                    ).animate(animation),
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: kSelectLanguageView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 400),
            key: state.pageKey,
            child: const SelectLanguageView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(
                      curve: Curves.easeInOutCirc,
                    ).animate(animation),
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: kUserDetailsView,
        pageBuilder: (context, state) {
          int userId = state.extra is int ? state.extra as int : -1;
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 400),
            key: state.pageKey,
            child: BlocProvider(
              create: (context) =>
                  GetUserDetailsCubit()..getUserDetails(userId),
              child: UserDetailsView(userId: userId),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(
                      curve: Curves.easeInOutCirc,
                    ).animate(animation),
                    child: child,
                  );
                },
          );
        },
      ),
    ],
  );
}
