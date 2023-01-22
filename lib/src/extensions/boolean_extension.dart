extension BooleanExtension on bool {
  /// Returns the opposite of the boolean value.
  bool not() => !this;

  /// Returns the boolean value if it is true, otherwise returns the [other] value.
  bool or(bool other) => this ? this : other;

  /// Returns the boolean value if it is false, otherwise returns the [other] value.
  bool and(bool other) => this ? other : this;

  /// Returns the boolean value if it is true, otherwise returns the [other] value.
  bool orElse(bool other) => this ? this : other;

  /// Returns the boolean value if it is false, otherwise returns the [other] value.
  bool andElse(bool other) => this ? other : this;

  /// Returns the boolean value if it is true, otherwise returns the [other] value.
  bool otherwise(bool other) => this ? this : other;

  /// Returns the boolean value if it is false, otherwise returns the [other] value.
  bool otherwiseNot(bool other) => this ? other : this;

  /// Returns the boolean value if it is true, otherwise returns the [other] value.
  bool otherwiseTrue(bool other) => this ? this : other;
}
