import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class SmallContainer extends StatelessWidget {
  SmallContainer({Key? key, required this.number}) : super(key: key);

  int number;

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
      width: 90.w,
      height: 6.h,
      child: Row(
        children: [
          const SizedBox(width: 20),
          SizedBox(
            width: 25,
            child: Text(
              '$number',
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff4664FF)),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 30),
          const Text(
            'Name of the file Dhikr',
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 12, color: Colors.black),
          ),
          const SizedBox(width: 10),
          const Text(
            '22.01.2023',
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 10, color: Colors.black),
            //  Color(0xff9F9F9F)),
          ),
          const SizedBox(width: 10),
          IconButton(
            iconSize: 30,
            enableFeedback: true,

            focusColor: Colors.green,
            splashColor: Colors.green,
            // style: ButtonStyle(
            //   fixedSize:
            //       MaterialStateProperty.all(Size(20, 15)),
            // ),
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/images/setting.svg',
              width: 20,
              height: 5,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 1.h),
        ],
      ),
    );
  }
}
