import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_squad/gen/assets.gen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppNoData extends StatelessWidget {
  final IconData? icon;
  final String? message;
  const AppNoData({
    Key? key,
    this.icon,
    this.message,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon == null
                ? Assets.images.logo.image(width: 10.h, height: 10.h)
                : Icon(
                    icon,
                    size: 100,
                  ),
            Padding(
              padding: const EdgeInsetsDirectional.all(20),
              child: Text(
                message ?? "noData".tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
