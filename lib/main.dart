import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';
import 'package:tasbix/widgets/counter_widget.dart';
import 'package:tasbix/widgets/generate_class.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DhikrAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return const MaterialApp(
          home: MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _switcher = false;

  final _titleDhikrController = TextEditingController();

  @override
  void dispose() {
    _titleDhikrController.dispose();
    super.dispose();
  }

  Future<Widget> getObjectFromHive() async {
    var box = await Hive.openBox('myBox');
    if (box.keys.isEmpty) {
      return const Text('no basa');
    }
    var listSaved = box.keys.toList();

    return Expanded(
      child: ListView.builder(
        itemCount: listSaved.length,
        itemBuilder: (context, index) {
          var dhikr = box.get(listSaved[index]) as Dhikr;

          return Container(
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              color: Color(0xffF9F9F9),
            ),
            width: mapperOrientation(portrait: 90.w, landscape: 150.w),
            height: 6.h,
            child: Row(
              children: [
                SizedBox(width: 5.5.w),
                SizedBox(
                  width: 7.w,
                  child: Text(
                    dhikr.counter.toString(),
                    maxLines: 3,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Color(0xff4664FF)),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    dhikr.title,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 2.5.w),
                Text(
                  '${dhikr.dateTime.toLocal().day.toString()}.${dhikr.dateTime.toLocal().month.toString().padLeft(2, '0')}.${dhikr.dateTime.toLocal().year.toString()}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: Colors.black),
                  //  Color(0xff9F9F9F)),
                ),
                SizedBox(width: 2.5.w),
                IconButton(
                  enableFeedback: true,
                  focusColor: Colors.green,
                  splashColor: Colors.green,
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/images/setting.svg',
                    width: 5.w,
                    height: 1.5.w,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 1.h),
              ],
            ),
          );
        },
      ),
    );
  }

  void func() {
    setState(() {});
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
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 1.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffFFFFFF),
                      ),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              if (_switcher) {
                                setState(() {
                                  _switcher = !_switcher;
                                });
                              }
                            },
                            style: ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor: _switcher == false
                                  ? MaterialStateProperty.all(
                                      const Color(0xff4664FF))
                                  : MaterialStateProperty.all(
                                      const Color(0xffFFFFFF)),
                              minimumSize: MaterialStateProperty.all(Size(
                                  mapperOrientation(
                                      portrait: 36.2.w, landscape: 94.6.w),
                                  5.h)),
                              maximumSize: MaterialStateProperty.all(Size(
                                  mapperOrientation(
                                      portrait: 36.2.w, landscape: 94.6.w),
                                  5.h)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            child: Text(
                              'Activity',
                              style: _switcher
                                  ? const TextStyle(
                                      color: Color(0xff9E9E9E),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)
                                  : const TextStyle(
                                      color: Color(0xffFFFFFF),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                            ),
                          ),
                          OrientationBuilder(builder: (context, orientation) {
                            return const SizedBox(width: 4);
                          }),
                          TextButton(
                            onPressed: () {
                              if (_switcher == false) {
                                setState(() {
                                  _switcher = !_switcher;
                                });
                              }
                            },
                            style: ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor: _switcher
                                  ? MaterialStateProperty.all(
                                      const Color(0xff4664FF))
                                  : MaterialStateProperty.all(
                                      const Color(0xffFFFFFF)),
                              minimumSize: MaterialStateProperty.all(Size(
                                  mapperOrientation(
                                      portrait: 36.2.w, landscape: 94.6.w),
                                  5.h)),
                              maximumSize: MaterialStateProperty.all(Size(
                                  mapperOrientation(
                                      portrait: 36.2.w, landscape: 94.6.w),
                                  5.h)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            child: Text(
                              'Saved',
                              style: _switcher == false
                                  ? const TextStyle(
                                      color: Color(0xff9E9E9E),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)
                                  : const TextStyle(
                                      color: Color(0xffFFFFFF),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffFFFFFF),
                      ),
                      child: IconButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffFFFFFF)),
                          minimumSize: MaterialStateProperty.all(Size(
                              mapperOrientation(
                                  portrait: 15.w, landscape: 15.w),
                              6.h)),
                          maximumSize: MaterialStateProperty.all(Size(
                              mapperOrientation(
                                  portrait: 15.w, landscape: 15.w),
                              6.h)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/images/menu.svg',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                _switcher ? const SizedBox() : const CounterWidget(),
                _switcher ? const SizedBox() : SizedBox(height: 2.h),
                _switcher
                    ? const SizedBox()
                    : TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffFFFFFF)),
                          fixedSize: MaterialStateProperty.all(Size(
                              mapperOrientation(
                                  portrait: 91.w, landscape: 208.w),
                              5.5.h)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () {
                          showDialog<void>(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              alignment: Alignment.center,
                              actionsAlignment: MainAxisAlignment.spaceEvenly,
                              elevation: 24,
                              title: const Text(
                                'Save Dhikr',
                                textAlign: TextAlign.center,
                              ),
                              content: TextFormField(
                                controller: _titleDhikrController,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(24),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.amber,
                                      width: 2,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(24),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                  ),
                                  labelText: 'Title Dhikr',
                                ),
                              ),
                              actions: [
                                FloatingActionButton(
                                  onPressed: () async {
                                    var box = await Hive.openBox('myBox');
                                    var id =
                                        DateTime.now().millisecondsSinceEpoch;
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    var counter = prefs.containsKey('counter')
                                        ? prefs.getInt('counter')!
                                        : 0;
                                    box.put(
                                        id.toString(),
                                        Dhikr(
                                            title: _titleDhikrController.text,
                                            counter: counter,
                                            dateTime: DateTime.now()));

                                    void bbb() {
                                      Navigator.pop(context);
                                      setState(() {});
                                    }

                                    bbb();
                                  },
                                  backgroundColor: const Color(0xff4664FF),
                                  child: const Text('Save'),
                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  backgroundColor: const Color(0xff4664FF),
                                  child: const Text('Back'),
                                )
                              ],
                            ),
                          );
                        },
                        child: const Text(
                          'Save Dhikr',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xff4664FF)),
                        ),
                      ),
                _switcher ? const SizedBox() : SizedBox(height: 2.h),
                Container(
                  width: mapperOrientation(portrait: 91.w, landscape: 208.w),
                  height: _switcher
                      ? mapperOrientation(portrait: 80.3.h, landscape: 64.w)
                      : mapperOrientation(portrait: 45.5.h, landscape: 64.w),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    color: Color(0xffFFFFFF),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            mapperOrientation(portrait: 5.w, landscape: 20.w),
                        vertical:
                            mapperOrientation(portrait: 5.w, landscape: 5.w)),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              'Last saved Dhikrs',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: mapperOrientation(
                                portrait: 3.h, landscape: 1.h)),
                        FutureBuilder(
                          future: getObjectFromHive(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.data!;
                            }
                            return const Text('asd');
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

T mapperOrientation<T>({required T portrait, required T landscape}) {
  if (SizerUtil.orientation == Orientation.portrait) {
    return portrait;
  }
  return landscape;
}
