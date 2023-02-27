import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/features/method_orientation.dart';
import 'package:tasbix/widgets/provider.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    super.key,
  });

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
              context.read<MyFirstProvider>().decrement();
            },
            child: SvgPicture.asset(
              'assets/images/remove.svg',
            ),
          ),
          InkWell(
            onTap: () async {
              context.read<MyFirstProvider>().increment();
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
                    '${context.watch<MyFirstProvider>().counter}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 48,
                        color: Colors.white),
                  ),
                  Text(
                    'Dhikr ${context.read<MyFirstProvider>().counter}',
                    // style: GoogleFonts.gilroy,
                    style: const TextStyle(
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
              context.read<MyFirstProvider>().reset();
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
