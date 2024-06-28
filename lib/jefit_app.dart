import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jefit/config/theme/dark_theme_manager.dart';

class JefitApp extends StatelessWidget {
  const JefitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: DarkThemeManager.darkTheme,
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Jefit App'),
            ),
            body: const Center(
              child: Text('Hello World'),
            ),
          ),
        );
      },
    );
  }
}
