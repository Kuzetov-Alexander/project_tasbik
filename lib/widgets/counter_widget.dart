import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/widgets/myhome_page.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({
    super.key,
  });

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int counter = 0;

  final initPreferences = SharedPreferences.getInstance();

  Future<void> getcounter() async {
    final prefs = await initPreferences;
    if (prefs.containsKey('counter')) {
      counter = prefs.getInt('counter')!;
      setState(() {});
    } else {}
  }

  @override
  void initState() {
    getcounter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        color: Color(0xffFFFFFF),
      ),
      width: mapperOrientation(portrait: 91.w, landscape: 208.w),
      height: 25.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                mapperOrientation(
                  portrait: Size(35, 4.h),
                  landscape: Size(13.w, 13.w),
                ),
              ),
              maximumSize: MaterialStateProperty.all(
                mapperOrientation(
                  portrait: Size(35, 4.h),
                  landscape: Size(13.w, 13.w),
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xff778DFF)),
            ),
            onPressed: () async {
              final prefs = await initPreferences;
              if (counter > 0) {
                setState(() {
                  counter--;
                });
                await prefs.setInt('counter', counter);
              }
            },
            child: SvgPicture.asset(
              'assets/images/remove.svg',
            ),
          ),
          InkWell(
            onTap: () async {
              final prefs = await initPreferences;
              setState(() {
                counter++;
              });
              prefs.setInt('counter', counter);
            },
            child: Container(
              width: mapperOrientation(portrait: 39.w, landscape: 60.w),
              height: 18.h,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                color: Color(0xff4664FF),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$counter',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 48,
                        color: Colors.white),
                  ),
                  const Text(
                    'Dhikr',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                mapperOrientation(
                  portrait: Size(35, 4.h),
                  landscape: Size(13.w, 13.w),
                ),
              ),
              maximumSize: MaterialStateProperty.all(
                mapperOrientation(
                  portrait: Size(35, 4.h),
                  landscape: Size(13.w, 13.w),
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xff778DFF)),
            ),
            onPressed: () async {
              final prefs = await initPreferences;
              setState(() {
                counter = 0;
              });
              prefs.setInt('counter', counter);
            },
            child: SvgPicture.asset(
              'assets/images/update.svg',
            ),
          ),
        ],
      ),
    );
  }
}
