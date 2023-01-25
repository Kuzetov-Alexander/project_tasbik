import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class ButtonsWidget extends StatefulWidget {
  const ButtonsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ButtonsWidget> createState() => _ButtonsWidgetState();
}

class _ButtonsWidgetState extends State<ButtonsWidget> {
  final List<bool> _switcher = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  setState(() {
                    _switcher[0] = true;
                    for (int j = 0; j < _switcher.length; j++) {
                      if (j != 0) {
                        _switcher[j] = false;
                      }
                    }
                  });
                },
                style: ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: _switcher[0] == true
                      ? MaterialStateProperty.all(const Color(0xff4664FF))
                      : MaterialStateProperty.all(const Color(0xffFFFFFF)),
                  minimumSize: MaterialStateProperty.all(Size(50.w, 40)),
                  maximumSize: MaterialStateProperty.all(Size(50.w, 40)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: Text(
                  'Activity',
                  style: _switcher[0] == false
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
                  setState(() {
                    _switcher[1] = true;
                    for (int j = 0; j < _switcher.length; j++) {
                      if (j != 1) {
                        _switcher[j] = false;
                      }
                    }
                  });
                },
                style: ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: _switcher[1] == true
                      ? MaterialStateProperty.all(const Color(0xff4664FF))
                      : MaterialStateProperty.all(const Color(0xffFFFFFF)),
                  minimumSize: MaterialStateProperty.all(Size(35.5.w, 40)),
                  maximumSize: MaterialStateProperty.all(Size(35.5.w, 40)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: Text(
                  'Saved',
                  style: _switcher[1] == false
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
    );
  }
}
