import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/services/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const CREATERFLOW(),
    ),
  );
}

class CREATERFLOW extends StatelessWidget {
  const CREATERFLOW({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Premium Content Hub',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}
