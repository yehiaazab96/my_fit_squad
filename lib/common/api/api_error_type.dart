import 'package:easy_localization/easy_localization.dart';

const int success = 200;
const int unauthorizedError = 401;
const int validationError = 403;
const int badRequestError = 400;
const int notFound = 404;
const int serverError = 500;

enum ApiErrorType {
  noNetworkError,
  noDataError,
  generalError,
  unauthorizedError,
  validationError,
}

extension ApiErrorData on ApiErrorType {
  int get code {
    switch (this) {
      case ApiErrorType.generalError:
        return 500;
      case ApiErrorType.noDataError:
        return 404;
      case ApiErrorType.unauthorizedError:
        return 401;
      case ApiErrorType.validationError:
        return 403;
      case ApiErrorType.noNetworkError:
        return 500;

      default:
        return 100;
    }
  }

  String get message {
    switch (this) {
      case ApiErrorType.noNetworkError:
        return "connectionError".tr();
      case ApiErrorType.noDataError:
        return "noDataError".tr();
      case ApiErrorType.generalError:
        return "generalError".tr();
      case ApiErrorType.unauthorizedError:
        return "unAuthorizedError".tr();
      default:
        return "generalError".tr();
    }
  }
}
