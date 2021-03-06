import 'package:equatable/equatable.dart';
import 'package:fordev/presentation/protocols/protocols.dart';
import 'package:fordev/validation/protocols/protocols.dart';
import 'package:meta/meta.dart';

class CompareFieldsValidation extends Equatable implements FieldValidation {
  final String field;
  final String fieldToCompare;

  CompareFieldsValidation(
      {@required this.field, @required this.fieldToCompare});
  ValidationError validate(Map input) {
    return input[field] != null &&
            input[fieldToCompare] != null &&
            input[fieldToCompare] != input[field]
        ? ValidationError.invalidField
        : null;
  }

  @override
  // TODO: implement props
  List<Object> get props => [field, fieldToCompare];
}
