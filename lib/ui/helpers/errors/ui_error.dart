import 'package:fordev/ui/helpers/i18n/resources.dart';

enum UIError {
  unexpected,
  invalidCredentials,
  requiredField,
  invalidField,
  emailInUse
}

extension UIErrorExtension on UIError {
  String get description {
    switch (this) {
      case UIError.invalidCredentials:
        return R.strings.invalidCredentials;
      case UIError.unexpected:
        return R.strings.unexpected;
      case UIError.requiredField:
        return R.strings.requiredField;
      case UIError.invalidField:
        return R.strings.invalidField;
      case UIError.emailInUse:
        return R.strings.emailInUse;
      default:
        return '';
    }
  }
}
