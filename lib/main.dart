import 'package:agendamiento_canchas/config/router/app_router.dart';
import 'package:agendamiento_canchas/config/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  final prefs = SharedPreferencesData();
  await prefs.initPrefs();
  runApp(const ProviderScope(child: Agendamiento()));
}

class Agendamiento extends ConsumerWidget {
  const Agendamiento({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
        title: 'Agendamiento',
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter);
  }
}
