class WhereCriteria {
  final Object field;
  final Object? isEqualTo;
  final Object? anotherIsEqualTo;
  final Object? isNotEqualTo;
  final Object? isLessThan;
  final Object? isLessThanOrEqualTo;
  final Object? isGreaterThan;
  final Object? isGreaterThanOrEqualTo;
  final Object? arrayContains;
  final List<Object?>? arrayContainsAny;
  final List<Object?>? whereIn;
  final List<Object?>? whereNotIn;
  final bool? isNull;
  final Object? anotherField; // Add anotherField parameter

  WhereCriteria({
    required this.field,
    this.isEqualTo,
    this.anotherIsEqualTo,
    this.isNotEqualTo,
    this.isLessThan,
    this.isLessThanOrEqualTo,
    this.isGreaterThan,
    this.isGreaterThanOrEqualTo,
    this.arrayContains,
    this.arrayContainsAny,
    this.whereIn,
    this.whereNotIn,
    this.isNull,
    this.anotherField, // Initialize anotherField parameter
  });
}
