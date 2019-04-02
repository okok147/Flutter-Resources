import 'package:maugost/constants/strings.dart';

class RavePayException implements Exception {
  String message;

  RavePayException(this.message);

  @override
  String toString() {
    if (message == null) return Strings.unKnownError;
    return message;
  }
}

class CardException extends RavePayException {
  CardException(String message) : super(message);
}

class ChargeException extends RavePayException {
  ChargeException(String message) : super(message);
}

class ExpiredAccessCodeException extends RavePayException {
  ExpiredAccessCodeException(String message) : super(message);
}

class InvalidAmountException extends RavePayException {
  int amount = 0;

  InvalidAmountException(this.amount)
      : super('$amount is not a valid '
            'amount. only positive non-zero values are allowed.');
}

class InvalidEmailException extends RavePayException {
  String email;

  InvalidEmailException(this.email) : super('$email  is not a valid email');
}
