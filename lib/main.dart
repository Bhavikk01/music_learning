import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/config/theme.dart';
import 'app/constants/constants.dart';
import 'app/constants/route_paths.dart';
import 'app/constants/router.dart' as router;
import 'app/data/helper/dependencies.dart' as dep;
import 'app/models/address.dart';
import 'app/models/enums/user_status.dart';
import 'app/models/user.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting();

  await Hive.initFlutter();
  Hive
    ..registerAdapter(UserAdapter())
    ..registerAdapter(AddressAdapter())
    ..registerAdapter(UserStatusAdapter());

  await Hive.openBox(Constants.hiveUserDatabase);

  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        onGenerateRoute: router.generateRoutes,
        initialRoute: (FirebaseAuth.instance.currentUser == null)
            ? RoutePaths.onBoardingScreen
            : RoutePaths.homePage,
        theme: themeData(
          ThemeData.light(),
        ),
      )
    );
  }
}
