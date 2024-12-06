import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minified_commerce/common/utils/app_routes.dart';
import 'package:minified_commerce/common/utils/environment.dart';
import 'package:minified_commerce/common/utils/kstrings.dart';
import 'package:minified_commerce/src/auth/controllers/auth_notifier.dart';
import 'package:minified_commerce/src/auth/controllers/password_notifier.dart';
import 'package:minified_commerce/src/products/controllers/colors_sizes_notifier.dart';
import 'package:minified_commerce/src/products/controllers/product_notifier.dart';
import 'package:minified_commerce/src/categories/controllers/category_notifier.dart';
import 'package:minified_commerce/src/home/controllers/home_tab_notifier.dart';
import 'package:provider/provider.dart';

import 'src/entry_point/controller/bottom_tab_notifier.dart';
import 'src/onboarding/controllers/onboarding_notifier.dart';
import 'src/splashscreen/views/splashscreen_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // load the correct environment.
  await dotenv.load(fileName: Environment.fileName);

  await GetStorage.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => OnBoardingNotifier()),
    ChangeNotifierProvider(create: (context) => TabIndexNotifier()),
    ChangeNotifierProvider(create: (context) => CategoryNotifier()),
    ChangeNotifierProvider(create: (context) => HomeTabNotifier()),
    ChangeNotifierProvider(create: (context) => ProductNotifier()),
    ChangeNotifierProvider(create: (context) => ColorsSizesNotifier()),
    ChangeNotifierProvider(create: (context) => PasswordNotifier()),
    ChangeNotifierProvider(create: (context) => AuthNotifier()),
  ],
  child: const MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ScreenUtilInit(
        designSize: screenSize,
        minTextAdapt: true,
        splitScreenMode: false,
        useInheritedMediaQuery: true,
        builder: (_, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppText.kAppName,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            routerConfig: router,
          );
        });
    child:
    const SplashScreen();
  }
}
