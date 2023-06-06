import 'package:my_fit_squad/common/api/api_error_type.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/injection/injection_container.dart' as di;

mixin BaseViewModel {
  void handleError(
      {ApiErrorType errorType = ApiErrorType.generalError, message}) {
    if (errorType == ApiErrorType.unauthorizedError) {
      // showToastMessage(message ?? errorType.message);
      showToastMessage("You need to login again");
      ProviderScope.containerOf(Constants.navigatorKey.currentContext!)
          .read(di.userProvider.notifier)
          .signout();
    } else {
      showToastMessage(message ?? errorType.message);
    }
  }

  void showToastMessage(String message) {
    if (Constants.navigatorKey.currentContext != null) {
      ScaffoldMessenger.of(Constants.navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: Theme.of(Constants.navigatorKey.currentContext!)
                .textTheme
                .labelMedium,
          ),
          backgroundColor: Theme.of(Constants.navigatorKey.currentContext!)
              .colorScheme
              .inversePrimary,
        ),
      );
    }
  }

  void showCustomDialog(Dialog dialog) {
    showDialog(
        // barrierDismissible: false,
        context: Constants.navigatorKey.currentContext!,
        builder: (_) => dialog);
  }

  void navigateToScreen(WidgetBuilder screen,
      {bool removeTop = false, bool replace = false, Function? onReturn}) {
    hideKeyboard();
    if (removeTop) {
      Constants.navigatorKey.currentState
          ?.pushAndRemoveUntil(
              MaterialPageRoute(builder: screen), (route) => false)
          .then((value) => onReturn != null ? onReturn() : null);
    } else if (replace) {
      Constants.navigatorKey.currentState
          ?.pushReplacement(MaterialPageRoute(builder: screen))
          .then((value) => onReturn != null ? onReturn() : null);
    } else {
      Constants.navigatorKey.currentState
          ?.push(MaterialPageRoute(builder: screen))
          .then((value) => onReturn != null
              ? (value != null ? onReturn(value) : onReturn())
              : null);
    }
  }

  void navigateToScreenNamed(
    String routeName, {
    bool removeTop = false,
    bool replace = false,
    Function? onReturn,
    dynamic arguments,
    GlobalKey<NavigatorState>? navigatorKey,
  }) {
    if (removeTop) {
      (navigatorKey ?? Constants.navigatorKey)
          .currentState
          ?.pushNamedAndRemoveUntil(
              routeName, arguments: arguments, (route) => false)
          .then((value) => onReturn != null ? onReturn() : null);
    } else if (replace) {
      (navigatorKey ?? Constants.navigatorKey)
          .currentState
          ?.pushReplacementNamed(routeName, arguments: arguments)
          .then((value) => onReturn != null ? onReturn() : null);
    } else {
      (navigatorKey ?? Constants.navigatorKey)
          .currentState
          ?.pushNamed(routeName, arguments: arguments)
          .then((value) => onReturn != null ? onReturn(value) : null);
    }
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  buildAppDialog(BuildContext context, Widget dialogChild) {
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: dialogChild),
    );

    showCustomDialog(dialog);
  }

  String searchKeyword = "";
  changeSearchKeyword(
    String keyWord,
  ) {
    searchKeyword = keyWord;
  }
}
