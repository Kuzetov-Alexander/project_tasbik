import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({
    super.key,
  });

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int counter = 33;

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
      width: 100.w,
      height: 25.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(35, 4.h)),
              maximumSize: MaterialStateProperty.all(Size(35, 4.h)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xff778DFF)),
            ),
            onPressed: () {
              setState(() {
                counter--;
              });
            },
            child: SvgPicture.asset(
              'assets/images/remove.svg',
            ),
          ),
          Container(
            width: 39.w,
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
                  // style: GoogleFonts.gilroy,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          TextButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(35, 4.h)),
              maximumSize: MaterialStateProperty.all(Size(35, 4.h)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xff778DFF)),
            ),
            onPressed: () {
              setState(() {
                counter = 33;
              });
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
