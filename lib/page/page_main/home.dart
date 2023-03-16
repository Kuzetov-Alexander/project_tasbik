import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/import.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    debugPrint('--------new build MyHomePage');
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 2.h),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: ButtonsList(),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 3.h)),
              SliverToBoxAdapter(
                child: activityButtonTrue(
                    active: const CounterWidget(), passive: const SizedBox()),
              ),
              SliverToBoxAdapter(
                child: activityButtonTrue(
                    active: SizedBox(height: 2.h), passive: const SizedBox()),
              ),
              SliverToBoxAdapter(
                child: activityButtonTrue(
                    active: const ButtonSaveDhikr(), passive: const SizedBox()),
              ),
              SliverToBoxAdapter(
                child: activityButtonTrue(
                    active: SizedBox(height: 2.h), passive: const SizedBox()),
              ),
              const SliverFillRemaining(
                child: BigContainer(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget activityButtonTrue({required Widget active, required Widget passive}) {
    if (context.watch<IntProvider>().switcher) {
      return active;
    }
    return passive;
  }
}
