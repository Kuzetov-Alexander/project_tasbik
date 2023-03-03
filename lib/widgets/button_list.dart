import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/features/method_orientation.dart';
import 'package:tasbix/widgets/provider.dart';

class ButtonsList extends StatefulWidget {
  const ButtonsList({super.key});

  @override
  State<ButtonsList> createState() => _ButtonsListState();
}

class _ButtonsListState extends State<ButtonsList> {
  @override
  Widget build(BuildContext context) {
    debugPrint('--------new build ButtonsList');
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 1.w, horizontal: 1.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffFFFFFF),
          ),
          child: SizedBox(
            width: mapperOrientation(portrait: 74.3.w, landscape: 190.5.w),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        context.read<IntProvider>().toSwitch();
                      });
                    },
                    style: ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: context.read<IntProvider>().switcher
                          ? MaterialStateProperty.all(const Color(0xff4664FF))
                          : MaterialStateProperty.all(const Color(0xffFFFFFF)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Text(
                      'Activity',
                      style: context.read<IntProvider>().switcher == false
                          ? const TextStyle(
                              color: Color(0xff9E9E9E),
                              fontSize: 14,
                              fontWeight: FontWeight.w400)
                          : const TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(width: 1.3.w),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        context.read<IntProvider>().toSwitch();
                      });
                    },
                    style: ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: context.read<IntProvider>().switcher ==
                              false
                          ? MaterialStateProperty.all(const Color(0xff4664FF))
                          : MaterialStateProperty.all(const Color(0xffFFFFFF)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Text(
                      'Saved',
                      style: context.read<IntProvider>().switcher
                          ? const TextStyle(
                              color: Color(0xff9E9E9E),
                              fontSize: 14,
                              fontWeight: FontWeight.w400)
                          : const TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 3.w),
        Container(
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffFFFFFF),
          ),
          child: IconButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xffFFFFFF)),
              minimumSize: MaterialStateProperty.all(Size(
                  mapperOrientation(portrait: 15.w, landscape: 15.w), 6.h)),
              maximumSize: MaterialStateProperty.all(Size(
                  mapperOrientation(portrait: 15.w, landscape: 15.w), 6.h)),
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
    );
  }
}
