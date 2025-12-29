import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize_loyalty_assignment/core/utils/validators.dart';

void main() {
  group('Name Validator', () {
    test('Should return error when name is empty', () {
      final invalidNames = ['', '   '];
      for (var name in invalidNames) {
        expect(Validators.validateName(name), 'Please enter your name');
      }
    });

    test('Should return error when name is shorter than 2 chars', () {
      final invalidNames = ['a', 'b', 'C'];
      for (var name in invalidNames) {
        expect(Validators.validateName(name), 'Name must be 2-10 characters long');
      }
    });

    test('Should return error when name is longer than 10 chars', () {
      final invalidNames = ['abcdefghijkl', 'longusername123'];
      for (var name in invalidNames) {
        expect(Validators.validateName(name), 'Name must be 2-10 characters long');
      }
    });

    test('Should return error when name contains invalid characters', () {
      final invalidNames = ['abc!', 'it\'s me', 'name@me', 'user#1'];
      for (var name in invalidNames) {
        expect(Validators.validateName(name), 'Name can only contain English letters, numbers, "-", "_", or "."');
      }
    });

    test('Should return error when name contains non-English characters', () {
      final invalidNames = ['สมชาย', 'Johnดี', 'ユーザー'];
      for (var name in invalidNames) {
        expect(Validators.validateName(name), 'Name can only contain English letters, numbers, "-", "_", or "."');
      }
    });

    test('Should trim spaces before validating', () {
      final validNames = ['  John  ', '  alice123', 'user_name  ', '  user.name  '];
      for (var name in validNames) {
        expect(Validators.validateName(name), null);
      }
    });

    test('Should pass when name is valid', () {
      final validNames = ['John', 'alice123', 'user_name', 'user.name', 'User-01'];
      for (var name in validNames) {
        expect(Validators.validateName(name), null);
      }
    });
  });
}
