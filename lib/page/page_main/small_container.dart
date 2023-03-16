import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/features/method_orientation.dart';
import 'package:tasbix/page/page_main/edit_alert_dialog.dart';
import 'package:tasbix/import.dart';

class SmallContainer extends StatelessWidget {
  const SmallContainer({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('--------new build smallContainer');
    final myListDhikr = context.watch<IntProvider>().listDhikr;

    if (myListDhikr.isEmpty) {
      return const Text('NO BASA');
    }

    return ListView.builder(
      shrinkWrap: true,
      itemExtent: 6.h,
      itemCount: myListDhikr.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          background: const SizedBox(),
          onDismissed: (direction) {
            context.read<IntProvider>().deleteDhikr(index);
          },
          child: Container(
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
                SizedBox(
                  width: 7.w,
                  child: Text(
                    myListDhikr[index].counter.toString(),
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
                    myListDhikr[index].title,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 2.5.w),
                Text(
                  '${myListDhikr[index].dateTime.toLocal().day.toString()}.${myListDhikr[index].dateTime.toLocal().month.toString().padLeft(2, '0')}.${myListDhikr[index].dateTime.toLocal().year.toString()}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: Colors.black),
                  //  Color(0xff9F9F9F)),
                ),
                SizedBox(width: 2.5.w),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => EditAlertDialog(index: index));
                  },
                  icon: SvgPicture.asset(
                    'assets/images/setting.svg',
                    height: 1.3.w,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 1.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
