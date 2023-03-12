import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/generated/codegen_loader.g.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:tasbix/screens/mainPage/big_container.dart';
import 'package:tasbix/screens/mainPage/button_list.dart';
import 'package:tasbix/screens/mainPage/button_save_dhikr.dart';
import 'package:tasbix/screens/mainPage/counter_widget.dart';
import 'package:tasbix/screens/mainPage/generate_class.dart';
import 'package:tasbix/screens/mainPage/provider.dart';
import 'package:tasbix/screens/mainPage/setting.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(50)) {
    Hive.registerAdapter(DhikrAdapter());
  }
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('ru'),
      startLocale: const Locale('ru'),
      saveLocale: true,
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
        return ChangeNotifierProvider(
          create: (_) => IntProvider(),
          child: MaterialApp(
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
            initialRoute: '/',
            routes: {
              '/': (context) => const MyHomePage(),
              '/second': (context) => const SetApp(),
            },
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    debugPrint('--------new build MyHomePage');
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 2.h),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: ButtonsList()),
              SliverToBoxAdapter(child: SizedBox(height: 3.h)),
              SliverToBoxAdapter(
                child: activityButtonTrue(
                    active: const CounterWidget(), passive: const SizedBox()),
              ),
              SliverToBoxAdapter(
                child: activityButtonTrue(
                    active: SizedBox(height: 2.h), passive: const SizedBox()),
              ),
              SliverToBoxAdapter(
                child: activityButtonTrue(
                    active: const ButtonSaveDhikr(), passive: const SizedBox()),
              ),
              SliverToBoxAdapter(
                child: activityButtonTrue(
                    active: SizedBox(height: 2.h), passive: const SizedBox()),
              ),
              const SliverFillRemaining(
                child: BigContainer(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget activityButtonTrue({required Widget active, required Widget passive}) {
    if (context.watch<IntProvider>().switcher) {
      return active;
    }
    return passive;
  }
}
