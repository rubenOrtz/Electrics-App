import 'package:electrician_app/core/utils/validators.dart';
import 'package:electrician_app/core/constants/app_strings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators', () {
    group('email', () {
      test('valid email returns null', () {
        expect(Validators.email('test@example.com'), null);
      });
      test('empty email returns required error', () {
        expect(Validators.email(''), AppStrings.emailRequired);
      });
      test('invalid email returns invalid error', () {
        expect(Validators.email('invalid-email'), AppStrings.emailInvalid);
      });
    });

    group('positiveNumber', () {
      test('valid positive number returns null', () {
        expect(Validators.positiveNumber('10'), null);
      });
      test('negative number returns error', () {
        expect(Validators.positiveNumber('-5'), AppStrings.mustBePositive);
      });
      test('zero returns error', () {
        expect(Validators.positiveNumber('0'), AppStrings.mustBePositive);
      });
      test('non-numeric returns error', () {
        expect(Validators.positiveNumber('abc'), AppStrings.mustBePositive);
      });
    });

    group('cableSection', () {
      test('standard section returns null', () {
        expect(Validators.cableSection('1.5'), null);
        expect(Validators.cableSection('2.5'), null);
        expect(Validators.cableSection('240'), null);
      });

      test('non-standard section returns error', () {
        expect(Validators.cableSection('3.0'), contains('no estándar'));
      });

      test('small section returns minimum error', () {
        expect(Validators.cableSection('0.5'), contains('mínima'));
      });
    });
  });
}
