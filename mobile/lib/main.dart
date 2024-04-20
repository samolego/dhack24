import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trgovinavigator/constants.dart';
import 'package:trgovinavigator/ui/screen/MainAppScreen.dart';

Future<void> main() async {
  await Supabase.initialize(url: DB_URL, anonKey: DB_KEY);
  runApp(const TrgoviNavigatorApp());
}

class TrgoviNavigatorApp extends StatelessWidget {
  const TrgoviNavigatorApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrgoviNavigator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryDark),
        useMaterial3: true,
        typography: Typography.material2021(),
        splashFactory: InkSparkle.splashFactory,
      ),
      home: const MainAppScreen(),
    );
  }
}
