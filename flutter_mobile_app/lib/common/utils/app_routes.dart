import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minified_commerce/src/auth/views/registration_screen.dart';
import 'package:minified_commerce/src/products/views/product_screen.dart';
import 'package:minified_commerce/src/auth/views/login_screen.dart';
import 'package:minified_commerce/src/categories/views/categories_screen.dart';
import 'package:minified_commerce/src/categories/views/category_screen.dart';
import 'package:minified_commerce/src/notifications/views/notifications_screen.dart';
import 'package:minified_commerce/src/search/views/search_screen.dart';

import '../../src/entry_point/views/entry_point.dart';
import '../../src/onboarding/views/onboarding_screen.dart';
import '../../src/splashscreen/views/splashscreen_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


final GoRouter _router = GoRouter(
   navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => AppEntryPoint(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnBoardingScreen(),
    ),
    // GoRoute(
    //   path: '/review',
    //   builder: (context, state) => const ReviewsPage(),
    // ),
    // GoRoute(
    //   path: '/policy',
    //   builder: (context, state) => const PolicyPage(),
    // ),
    // GoRoute(
    //   path: '/verification',
    //   builder: (context, state) => const VerificationPage(),
    // ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    // GoRoute(
    //   path: '/help',
    //   builder: (context, state) => const HelpCenterPage(),
    // ),
    // GoRoute(
    //   path: '/orders',
    //   builder: (context, state) => const OrdersPage(),
    // ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegistrationScreen(),
    ),
    GoRoute(
      path: '/category',
      builder: (context, state) => const CategoryScreen(),
    ),
     GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoriesScreen(),
    ),

    // GoRoute(
    //   path: '/addaddress',
    //   builder: (context, state) => const AddAddress(),
    // ),

    // GoRoute(
    //   path: '/addresses',
    //   builder: (context, state) => const AddressesListPage(),
    // ),

     GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationScreen(),
    ),

    //  GoRoute(
    //   path: '/tracking',
    //   builder: (context, state) => const TrackOrderPage(),
    // ),

    // GoRoute(
    //   path: '/checkout',
    //   builder: (context, state) => const CheckoutPage(),
    // ),

    //   GoRoute(
    //   path: '/successful',
    //   builder: (context, state) => const SuccessfulPayment(),
    // ),

    //   GoRoute(
    //   path: '/failed',
    //   builder: (context, state) => const FailedPayment(),
    // ),

    GoRoute(
      path: '/product/:id',
      builder: (BuildContext context, GoRouterState state) {
        final productId = state.pathParameters['id'];
        return ProductScreen(productId: productId.toString());
      },
    ),
  ],
);

GoRouter get router => _router;