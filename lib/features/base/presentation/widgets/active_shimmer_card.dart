import 'package:my_fit_squad/features/base/presentation/widgets/shimmer_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyShimmerCard extends StatelessWidget {
  const MyShimmerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsetsDirectional.fromSTEB(3.w, 0.5.h, 3.w, 0.5.h),
        height: 20.h,
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(3.w),
          border: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 0.1.w),
        ),
        padding: EdgeInsets.only(
          bottom: 2.h,
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(
                    top: 0, bottom: 1.h, start: 0, end: 2.w),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(3.w),
                      bottomEnd: Radius.circular(3.w)),
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                child: Container(
                  color: Colors.transparent,
                  width: 50.w,
                  height: 7.h,
                ),
              ),
            ],
          ),
          ShimmerText(
            height: 3.h,
            margin: EdgeInsetsDirectional.only(start: 2.w, top: 1.h, end: 2.w),
          ),
          ShimmerText(
            height: 3.h,
            margin: EdgeInsetsDirectional.only(start: 2.w, top: 1.h, end: 2.w),
          )
        ]));
  }
}
