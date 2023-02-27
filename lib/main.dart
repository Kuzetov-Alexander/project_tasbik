import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/widgets/import_file.dart';
import 'package:tasbix/widgets/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(50)) {
    Hive.registerAdapter(DhikrAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          home: ChangeNotifierProvider(
            create: (context) => MyFirstProvider(),
            child: const MyHomePage(),
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
  bool switcher = false;
  Key _smallContainerKey = UniqueKey();

  refreshState() {
    print('refresh state HomePage');
    setState(() {
      _smallContainerKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      // const Color(0xffE5E5E5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 2.h),
          child: SingleChildScrollView(
            physics: SizerUtil.orientation == Orientation.portrait
                ? const NeverScrollableScrollPhysics()
                : const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const ButtonsList(),
                SizedBox(
                  height: 3.h,
                ),
                switcher ? const SizedBox() : const CounterWidget(),
                switcher ? const SizedBox() : SizedBox(height: 2.h),
                const ButtonSaveDhikr(),
                SizedBox(height: 2.h),
                BigContainer(
                  switcher: switcher,
                  smallContainerKey: _smallContainerKey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
