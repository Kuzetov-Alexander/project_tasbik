import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/generated/codegen_loader.g.dart';
import 'package:tasbix/generated/generate_class.dart';
import 'package:tasbix/import.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tasbix/page/page_authentification/reset_password.dart';
import 'package:tasbix/page/page_authentification/widget/firebase_stream.dart';
import 'generated/firebase_options.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(50)) {
    Hive.registerAdapter(DhikrAdapter());
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => IntProvider()),
            ChangeNotifierProvider(create: (_) => ProviderLocalisation()),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: TextTheme(
                bodyMedium: GoogleFonts.montserrat(
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
                labelLarge: GoogleFonts.montserrat(
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            routerConfig: GoRouter(
              routes: <RouteBase>[
                GoRoute(
                  path: '/',
                  builder: (BuildContext context, GoRouterState state) {
                    return const FirebaseStream();
                  },
                  routes: <RouteBase>[
                    GoRoute(
                      path: 'setting',
                      builder: (BuildContext context, GoRouterState state) {
                        return const SetApp();
                      },
                    ),
                    GoRoute(
                      path: 'registration',
                      builder: (BuildContext context, GoRouterState state) {
                        return const RegistrationPage();
                      },
                    ),
                    GoRoute(
                      path: 'signup',
                      builder: (BuildContext context, GoRouterState state) {
                        return const LoginPage();
                      },
                    ),
                    GoRoute(
                      path: 'verifymail',
                      builder: (BuildContext context, GoRouterState state) {
                        return const VerifyEmailScreen();
                      },
                    ),
                    GoRoute(
                      path: 'resetpass',
                      builder: (BuildContext context, GoRouterState state) {
                        return const ResetPasswordScreen();
                      },
                    ),
                  ],
                ),
              ],
            ),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          ),
        );
      },
    );
  }
}
