import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _switcher = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 2.h),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 1.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffFFFFFF),
                    ),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            if (_switcher == true) {
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
                            minimumSize:
                                MaterialStateProperty.all(Size(35.5.w, 40)),
                            maximumSize:
                                MaterialStateProperty.all(Size(35.5.w, 40)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: Text(
                            'Activity',
                            style: _switcher == true
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
                        const SizedBox(width: 4),
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
                            backgroundColor: _switcher == true
                                ? MaterialStateProperty.all(
                                    const Color(0xff4664FF))
                                : MaterialStateProperty.all(
                                    const Color(0xffFFFFFF)),
                            minimumSize:
                                MaterialStateProperty.all(Size(35.5.w, 40)),
                            maximumSize:
                                MaterialStateProperty.all(Size(35.5.w, 40)),
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
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xffFFFFFF)),
                        minimumSize: MaterialStateProperty.all(Size(15.w, 48)),
                        maximumSize: MaterialStateProperty.all(Size(15.w, 48)),
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
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xffFFFFFF)),
                        fixedSize:
                            MaterialStateProperty.all(Size(100.w, 5.5.h)),
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
              _switcher ? const SizedBox() : SizedBox(height: 2.h),
              _switcher
                  ? Expanded(
                      child: Container(
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          color: Color(0xffFFFFFF),
                        ),
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
                              const SmallContainer(
                                number: 14,
                              ),
                              SizedBox(height: 1.h),
                              const SmallContainer(
                                number: 9,
                              ),
                              SizedBox(height: 1.h),
                              const SmallContainer(
                                number: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        color: Color(0xffFFFFFF),
                      ),
                      width: 100.w,
                      height: 45.h,
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
                            const SmallContainer(
                              number: 14,
                            ),
                            SizedBox(height: 1.h),
                            const SmallContainer(
                              number: 9,
                            ),
                            SizedBox(height: 1.h),
                            const SmallContainer(
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
    );
  }
}
