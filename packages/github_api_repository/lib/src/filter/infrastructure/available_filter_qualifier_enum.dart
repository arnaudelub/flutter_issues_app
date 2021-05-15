enum AvailableFilterQualifier { state, author, assignee }

extension QualifierValue on AvailableFilterQualifier {
  static const qualifiers = {
    AvailableFilterQualifier.state: 'state',
    AvailableFilterQualifier.author: 'author',
    AvailableFilterQualifier.assignee: 'assignee',
  };

  /// ```dart
  /// final state = AvailableFilterQualifier.state;
  /// print(state.value); // 'state'
  /// ```
  String? get value => qualifiers[this];
}
