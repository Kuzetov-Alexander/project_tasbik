import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/features/method_orientation.dart';
import 'package:tasbix/import.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    List<AssetSource> listSound = [
      AssetSource('sound/button.wav'),
      AssetSource('sound/bumer.wav'),
      AssetSource('sound/fuck.wav'),
      AssetSource('sound/hren.wav'),
      AssetSource('sound/ohYes.wav'),
      AssetSource('sound/thankSir.wav'),
      AssetSource('sound/wee.wav'),
      AssetSource('sound/woo.wav'),
    ];
    final myProvider = context.read<IntProvider>();
    debugPrint('--------new build CounterWidget');
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
            onPressed: () {
              myProvider.decrement();
            },
            child: SvgPicture.asset(
              'assets/images/remove.svg',
            ),
          ),
          InkWell(
            enableFeedback: false,
            onTap: () {
              myProvider.player.play(listSound[0]);
              myProvider.increment();
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
                    '${context.watch<IntProvider>().counter}',
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
              myProvider.reset();
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
