# Example

From any place of your code, only call validateNIT function. Then this check the nit number and return an boolean value.

It require only nit as a param. This will be input to check.

```dart
import 'package:nit_validator/nit_validator.dart';

validateNIT("") == false
validateNIT("99999") == false
validateNIT("101735529") == true
validateNIT("1487010k") == true
validateNIT("1487010-k") == true
```

If it's ok, return `true` or else return `false`
