
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/data/services/dependency_injection.dart';
import 'app/data/services/translations_service.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/ui/layouts/main/main_layout.dart';
import 'app/ui/theme/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependecyInjection.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

   return ScreenUtilInit(
      builder: (_,__) {
        return GetMaterialApp(
          title: 'The_movie_app',
          debugShowCheckedModeBanner: false,
          theme: Themes().lightTheme,
          darkTheme: Themes().darkTheme,
          themeMode: ThemeMode.dark,
          translations: Translation(),
          locale: const Locale('en'),
          fallbackLocale: const Locale('en'),
          initialRoute: AppRoutes.HOME,
          unknownRoute: AppPages.unknownRoutePage,
          getPages: AppPages.pages,
          builder: (_, child) {
            return MainLayout(child: child!);
          },
        );
      },
    );
  }
}
