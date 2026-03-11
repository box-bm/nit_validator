final _regex = RegExp(r'^(\d+)-(\d|K)$');

/// Check nit number and return an boolean value. if it's ok, send `true` or else send `false`
///
/// It require only [nit] as a param. This will be input to check.
///
/// ```dart
/// validateNIT("") == false
/// validateNIT("99999") == false
/// validateNIT("101735529") == true
/// validateNIT("1487010k") == true
/// validateNIT("1487010-k") == true
/// ```
bool validateNIT(Object? nit) {
  if (nit == null) return false;

  // Convert text to upper case for every nit.
  String text = nit.toString().toUpperCase();
  if (text.isEmpty) return false;

  // If this not includes dash sign, we will add this to the nit
  if (!text.contains('-')) {
    text =
        '${text.substring(0, text.length - 1)}-${text.substring(text.length - 1)}';
  }

  // then by regex expression we will find all matches and get left side and right side
  final match = _regex.firstMatch(text);
  if (match == null) return false;

  // we take before and after values than the dash sign
  final String beforeDashValue = match.group(1)!;
  final String afterDashValue = match.group(2)!;

  int summationDigitsOfNIT = 0;
  final digits = beforeDashValue.codeUnits;
  for (int i = 0; i < digits.length; i++) {
    final digit = digits[digits.length - 1 - i] - 48; // '0' == 48
    summationDigitsOfNIT += digit * (i + 2);
  }

  final int calculatedLastValue = (11 - (summationDigitsOfNIT % 11)) % 11;
  final String validationRightValue =
      calculatedLastValue == 10 ? 'K' : calculatedLastValue.toString();

  return afterDashValue == validationRightValue;
}
