import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
                ? const SizedBox()
                : Icon(
                    icon,
                    size: 100,
                  ),
            Padding(
              padding: const EdgeInsetsDirectional.all(20),
              child: Text(
                message ?? "noData".tr(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
