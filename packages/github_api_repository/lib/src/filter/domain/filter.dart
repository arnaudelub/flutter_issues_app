import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter.freezed.dart';

const authorQualifier = 'author';
const statesQualifier = 'states';

@freezed
class Filter with _$Filter {
  const factory Filter({
    String? states,
    String? author,
  }) = _Filter;

  factory Filter.empty() => const Filter();
}
