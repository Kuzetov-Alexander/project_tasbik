import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/widgets/buttons_widget.dart';
import 'package:tasbix/widgets/counter_widget.dart';
import 'package:tasbix/widgets/small_container.dart';

void main() {
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 2.h),
            child: Column(
              children: [
                const ButtonsWidget(),
                SizedBox(
                  height: 3.h,
                ),
                const CounterWidget(),
                SizedBox(height: 2.h),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffFFFFFF)),
                    fixedSize: MaterialStateProperty.all(Size(100.w, 5.5.h)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Save Dhikr',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xff4664FF)),
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    color: Color(0xffFFFFFF),
                  ),
                  width: 100.w,
                  height: 43.5.h,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
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
                        SizedBox(height: 3.h),
                        SmallContainer(
                          number: 14,
                        ),
                        SizedBox(height: 1.h),
                        SmallContainer(
                          number: 9,
                        ),
                        SizedBox(height: 1.h),
                        SmallContainer(
                          number: 15,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
