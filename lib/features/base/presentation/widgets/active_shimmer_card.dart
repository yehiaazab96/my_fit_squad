import 'package:my_fit_squad/features/base/presentation/widgets/shimmer_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyShimmerCard extends StatelessWidget {
  const MyShimmerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsetsDirectional.only(start: 0, end: 0, top: 2.h, bottom: 2.h),
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(4.h),
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
                      topStart: Radius.circular(4.h),
                      bottomEnd: Radius.circular(4.h)),
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                child: Row(
                  children: [
                    Container(
                      color: Colors.transparent,
                      width: 10.w,
                      height: 5.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ShimmerText(
                  height: 3.h,
                  margin: EdgeInsetsDirectional.only(
                      start: 1.w, top: 1.h, end: 1.w),
                ),
              ),
              ShimmerText(
                height: 3.h,
                width: 10.w,
                margin:
                    EdgeInsetsDirectional.only(start: 1.w, top: 1.h, end: 1.w),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ShimmerText(
                  height: 3.h,
                  width: 10.w,
                  margin: EdgeInsetsDirectional.only(
                      start: 1.w, top: 1.h, end: 1.w),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: ShimmerText(
                  height: 3.h,
                  width: 10.w,
                  margin: EdgeInsets.symmetric(horizontal: 1.w),
                )),
              ],
            ),
          )
        ]));
  }
}
