import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppNoConnection extends StatelessWidget {
  final void Function()? onTap;
  const AppNoConnection({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.perm_scan_wifi,
                size: 100,
                color: Theme.of(context).primaryColor,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.all(20),
                child: Text(
                  "noConnection".tr(),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: onTap ?? () {},
                child: Text("tryAgain".tr()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
