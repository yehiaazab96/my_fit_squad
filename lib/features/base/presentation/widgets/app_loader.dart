import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppLoader extends StatelessWidget {
  const AppLoader();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: Container(
        // width: 100.w,
        // height: 95.h,
        color: Theme.of(context).colorScheme.inversePrimary,
        child: Center(
          child: Container(
              width: 10.w,
              height: 10.w,
              // padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.w),
                  color: Colors.white),
              child: SpinKitWaveSpinner(
                color: Theme.of(context).colorScheme.primary,
                waveColor: Theme.of(context).colorScheme.primary,
                // curve: Curves.ease,
              )),
        ),
      ),
    );
  }
}
