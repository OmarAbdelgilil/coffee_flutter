import 'package:coffe_front/core/di/di.dart';
import 'package:coffe_front/core/providers/token_provider.dart';
import 'package:coffe_front/features/auth/presentation/auth_screen.dart';
import 'package:coffe_front/features/navigations/presentation/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TokenProvider().init();
  configureDependencies();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(TokenProvider().token);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:
          TokenProvider().token == null
              ? const AuthScreen()
              : const NavigationScreen(),
    );
  }
}
