import 'package:formz/formz.dart';

enum NameValidationError { empty }

class Validator extends FormzInput<String, NameValidationError> {
  const Validator.pure() : super.pure('');
  const Validator.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    return value.isNotEmpty == true && value.length>=2 ?
    null : NameValidationError.empty;
  }
}