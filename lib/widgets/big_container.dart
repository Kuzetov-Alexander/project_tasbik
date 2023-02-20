import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/features/method_orientation.dart';
import 'package:tasbix/widgets/small_container.dart';

class BigContainer extends StatefulWidget {
  const BigContainer({super.key, required this.switcher});
  final bool switcher;

  @override
  State<BigContainer> createState() => _BigContainerState();
}

class _BigContainerState extends State<BigContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: mapperOrientation(portrait: 91.w, landscape: 208.w),
      height: widget.switcher
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
            horizontal: mapperOrientation(portrait: 5.w, landscape: 20.w),
            vertical: mapperOrientation(portrait: 5.w, landscape: 5.w)),
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
            SizedBox(height: mapperOrientation(portrait: 3.h, landscape: 1.h)),
            const SmallContainer(),
          ],
        ),
      ),
    );
  }
}
