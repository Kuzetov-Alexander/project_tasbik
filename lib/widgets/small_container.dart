import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/main.dart';

class SmallContainer extends StatefulWidget {
  const SmallContainer({Key? key, required this.number}) : super(key: key);

  final int number;

  @override
  State<SmallContainer> createState() => _SmallContainerState();
}

class _SmallContainerState extends State<SmallContainer> {
  @override
  Widget build(BuildContext context) {
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
              '${widget.number}',
              maxLines: 3,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff4664FF)),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 4.w),
          const Expanded(
            child: Text(
              'Name of the file Dhikr',
              textAlign: TextAlign.start,
              maxLines: 3,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: 2.5.w),
          const Text(
            '22.01.2023',
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 10, color: Colors.black),
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
  }
}
