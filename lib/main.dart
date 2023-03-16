import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/generated/codegen_loader.g.dart';
import 'package:tasbix/page/import.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tasbix/generated/generate_class.dart';
import 'firebase_options.dart';
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
              SliverToBoxAdapter(child: ButtonsList(
                onOpened: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SetApp(),
                    ),
                  ).whenComplete(() => setState(() {}));
                },
              )),
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
