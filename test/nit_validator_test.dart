import 'package:flutter_test/flutter_test.dart';

import 'package:nit_validator/nit_validator.dart';

void main() {
  test('Test correct NITs', () {
    expect(validateNIT("1487010k"), true);
    expect(validateNIT("101735529"), true);
    expect(validateNIT("136192-9"), true);
  });
  test('Test empty NITs values', () {
    expect(validateNIT(""), false);
    expect(validateNIT(" "), false);
    expect(validateNIT("-"), false);
    expect(validateNIT("/"), false);
  });
  test('Test wrong NITs', () {
    expect(validateNIT("9829389k"), false);
    expect(validateNIT("1487"), false);
  });
}
