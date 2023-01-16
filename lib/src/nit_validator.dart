RegExp _regex = RegExp(r"^(\d+)-(\d|K)$");

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
bool validateNIT(dynamic nit) {
  if (nit == null || nit.toString().isEmpty) return false;

  // Convert text to upper case for every nit.
  String text = nit.toString().toUpperCase();

  // If this not includes dash sign, we will add this to the nit
  if (!text.contains('-')) {
    text =
        '${text.substring(0, text.length - 1)}-${text.substring(text.length - 1)}';
  }

  // then by regex expression we will find all matches and get left side and right side
  var matches = _regex.allMatches(text);
  if (matches.isEmpty) return false;

  List<String?> nitGroups = matches.elementAt(0).groups([1, 2]);

  // we take before and after values than the dash sign
  String beforeDashValue = nitGroups.elementAt(0).toString(),
      afterDashValue = nitGroups.elementAt(1).toString();

  int summationDigitsOfNIT = 0;
  beforeDashValue
      .split('')
      .reversed
      .toList()
      .map((e) => int.parse(e))
      .toList()
      .asMap()
      .forEach((index, element) {
    summationDigitsOfNIT += (element * (index + 2));
  });
  int calculatedLastValue = (11 - (summationDigitsOfNIT % 11)) % 11;
  String validationRightValue =
      calculatedLastValue == 10 ? "K" : calculatedLastValue.toString();

  return afterDashValue == validationRightValue;
}
