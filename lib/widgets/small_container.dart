import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/features/method_orientation.dart';
import 'package:tasbix/widgets/generate_class.dart';

class SmallContainer extends StatefulWidget {
  const SmallContainer({super.key});

  @override
  State<SmallContainer> createState() => SmallContainerState();
}

class SmallContainerState extends State<SmallContainer> {
  void proverka() {
    print('asfsada');
  }

  Future<Widget> getObjectFromHive() async {
    var box = await Hive.openBox('myBox');
    if (box.keys.isEmpty) {
      return const Text('no basa');
    }
    var listSaved = box.keys.toList();

    return Expanded(
      child: ListView.builder(
        itemCount: listSaved.length,
        itemBuilder: (context, index) {
          var dhikr = box.get(listSaved[index]) as Dhikr;

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
                    dhikr.counter.toString(),
                    maxLines: 3,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Color(0xff4664FF)),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    dhikr.title,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 2.5.w),
                Text(
                  '${dhikr.dateTime.toLocal().day.toString()}.${dhikr.dateTime.toLocal().month.toString().padLeft(2, '0')}.${dhikr.dateTime.toLocal().year.toString()}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: Colors.black),
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
                    height: 1.3.w,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 1.h),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getObjectFromHive(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!;
        }
        return const Text('asd');
      },
    );
  }
}
