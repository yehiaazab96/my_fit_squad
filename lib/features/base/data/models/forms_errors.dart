class BaseFormError {
  final String? field;
  final String? message;

  BaseFormError({
    this.field,
    this.message,
  });

  List<Object?> get props => [field, message];
}
