import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import 'app_exception.dart';
import 'error_type.dart';

class UIErrorHandler {
  static String getLocalizedMessage(AppException error, BuildContext context) {
    switch (error.errorType) {
      case ErrorType.unexpectedError:
        return S.of(context).unexpectedError;
    }
  }
}
