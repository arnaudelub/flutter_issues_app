import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/src/filter/domain/filter.dart';

part 'filter_dto.freezed.dart';

@freezed
class FilterDto with _$FilterDto {
  const FilterDto._();

  const factory FilterDto({
    String? states,
    String? author,
  }) = _FilterDto;

  factory FilterDto.fromString(String filter) {
    final filterList = filter.split(' ');
    String? authorFilter;
    String? stateFilter;
    for (final filter in filterList) {
      final value = filter.split(':').last;
      if (filter.contains(authorQualifier)) {
        authorFilter = value;
      }
      if (filter.contains(statesQualifier)) {
        stateFilter = value;
      }
    }
    return FilterDto(states: stateFilter, author: authorFilter);
  }

  Filter toDomain() => Filter(states: states, author: author);
}
