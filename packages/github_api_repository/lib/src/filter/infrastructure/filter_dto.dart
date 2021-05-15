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
    final splittedString = filter.split(' ');
    String? states;
    String? author;
    for (final string in splittedString) {
      if (string.contains(':')) {
        final keyValue = string.split(':');
        final key = keyValue[0];
        final value = keyValue[1];
        if (key == 'states') {
          states = value;
        } else if (key == 'author') {
          author = value;
        }
      }
    }
    return FilterDto(author: author, states: states);
  }

  Filter toDomain() => Filter(states: states, author: author);
}
